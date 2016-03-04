	;(function ($) {
			function scrollImages(box,config) {
				var initConfig = {
					loop:true,
					auto:true,
				};
				 this.box = $(box);
				 this.config = $.extend(initConfig, config||{});
				 this.width = this.config.width ||this.box.children().eq(0).width();
				 this.size = this.config.size||this.box.children().length;
				 this.loop = this.config.loop;
				 this.auto = this.config.auto;
				 this.interval = this.config.interval||3000;
				 this.scroll_time = 300;
				 this.minleft = -this.width*(this.size-1);
				 this.maxleft = 0;
				 this.currentleft = 0;
				 this.point_x = null;
				 this.point_y = null;
				 this.move_left = false;
				 this.index = 0;
				 this.busy = false;
				 this.timer;
				 this.init();
			}

			$.extend(scrollImages.prototype, {
				init: function () {
					this.bind_event();
					this.init_loop();
					this.auto_scroll();	  
				},
				bind_event: function () {
					 var self = this;
					 self.box.on('touchstart', function(event) {
					 	if (event.touches.length == 1 && ! elf.busy) {
							self.point_x = event.touches[0].screenX;
							self.point_y = event.touches[0].screenY;
						}
					 }).on('touchmove', function(event) {
					 	if (event.touches.length == 1 &&!self.busy) {
							return self.move(event.touches[0].screenX,event.touches[0].screenY);//这里根据返回值觉得是否阻止默认touch事件
						}
					 }).on('touchend', function(event) {
					 	!self.busy && self.move_end();
					 });
				},
				init_loop: function () {
					if (this.box.children().length == this.size &&this.loop) {
						this.currentleft = -this.width;
						this.maxleft = -this.width;
						this.minleft = -this.width*this.size;
						this.box.prepend(this.box.children().eq(this.size-1).clone()).append(this.box.children().eq(1).clone()).css(this.get_style(2));
						this.box.css("width",this.width*(this.size+2));
					} else {
						this.loop = false;
						this.box.css("width",this.width*this.size);
					};	  
				},
				auto_scroll: function () {
					 var self = this;
					 if (!self.loop || !self.auto)return;
					 clearTimeout(self.timer);
					 self.timer = setTimeout(function () {
					 	 self.go_index(self.index+1); 
					 }, self.interval); 
				},

				go_index: function (ind) {//滚动到指定索引页面
					 var self = this;
					 if (self.busy) return;
					 clearTimeout(self.timer);
					 self.busy = true;
					 if(self.loop){//如果循环
					 	ind = ind<0?-1:ind;
					 	ind = ind>self.size?self.size:ind;
					 } else {
					 	ind = ind<0?0:ind;
					 	ind = ind>=self.size?(self.size-1):ind;
					 }

					 if(!self.loop && (self.currentleft == -(self.width*ind))) {
					 	self.complete(ind);
					 } else if (self.loop && (self.currentleft == -self.width*(ind+1))) {
					 	self.complete(ind);
					 } else {
					 	if(ind == -1||ind == self.size){//循环滚动边界
					 		self.index = ind == -1?(self.size-1):0;
					 		self.currentleft = ind==-1?0:-self.width*(self.size+1);
					 	} else {
					 		self.index = ind;
					 		self.currentleft = -(self.width*(self.index+(self.loop?1:0)));
					 	}
					 	self.box.css(this.get_style(1));
					 	setTimeout(function () {
					 		  self.complete(ind);
					 	}, self.scroll_time);
					 }
				},

				complete: function (ind) {
					 var self = this;
					 self.busy = false;
					 self.config.callback && self.config.callback(self.index);
					 if(ind==-1){
					 	self.currentleft = self.minleft;
					 } else if (ind==self.size) {
					 	self.currentleft = self.maxleft;
					 }
					 self.box.css(this.get_style(1));
					
					 self.auto_scroll();
				},
				get_style: function (fig) {
					 var x = this.currentleft,
					 	time = fig ==1?this.scroll_time:0;
					 	return {
					 		"-webkit-transition":"-webkit-transform"+time+"ms",
							"-webkit-transform":"translate3d("+x+"px,0,0)",
							"-webkit-backface-visibility":"hiden",
							"transition":"-webkit-transform"+time+"ms",
							"transform":"translate3d("+x+"px,0,0)",
					 	}

				},
				next: function () {
					 if (!this.busy) {
					  	this.go_index(this.index+1);
					  } 
				},
				pre : function () {
					 if(!self.busy){
					 	this.go_index(self.index-1);
					 } 
				},
				move: function (point_x,point_y) {//滑动屏幕处理函数
					 var changeX = point_x - (this.point_x ===null?point_x:this.point_x),
					  	 changeY = point_y - (this.point_y === null?point_y:this.point_y),
					 	 marginleft = this.currentleft,
					 	 return_value = false, 
					     sin = changeY/Math.sqrt(changeX*changeX+changeY*changeY);
					 this.currentleft = marginleft+changeX;
					 this.move_left = changeX<0;
					 if (sin>Math.sin(Math.PI/3)||sin<-Math.sin(Math.PI/3)) {//滑动屏幕角度范围：PI/3  -- 2PI/3
					 	return_value = true;//不阻止默认行为
					 }
					 console.log("sss:"+changeX);
					 this.point_y = point_y;
					 this.point_x = point_x;
					 this.box.css(this.get_style(2));
					 return return_value;
				},
				move_end: function () {
					 var changeX = this.currentleft%this.width,ind;
					 if (this.currentleft<this.minleft) {//手指向左滑动
					  	ind = this.index+1;
					  }  else if (this.currentleft>this.maxleft) {//手指向右滑动
					  	ind = this.index-1;
					  } else if (changeX!=0) {
					  	if(this.move_left){
					  		ind = this.index+1;
					  	} else {
					  		ind = this.index -1	
					  	} 
					  } else {
					  	ind= this.index;
					  }
					  this.point_x = this.point_y = null;
					  this.go_index(ind);
				},

			});

			$.extend($,{
				scrollImg: function (box,config) {
							// console.log(config.loop);
							 var scrollImg = new scrollImages(box,config);
							 return {
							 	next: function () {
							 		 scrollImg.next(); 
							 	},
							 	prev: function () {
							 		 scrollImg.prev(); 
							 	},
							 	go: function (ind) {
							 		 scrollImg.go_index(parseInt(index)||0); 
							 	}

							 }
						}
			});
			

		})(Zepto)