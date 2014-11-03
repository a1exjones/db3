(function() { // We use this anonymous function to create a closure.

	var app = angular.module('splatter-web', ['ngResource']);
	
	app.factory('User', function($resource) {
		return $resource('http://jones.sqrawler.com/api/users/:id.json', {} , {update:{method:'PUT',url:'http://jones.sqrawler.com/api/users/:id'}})
	});
		
	app.factory('ViewSplatt', function($resource) {
		return $resource('http://jones.sqrawler.com/api/users/splatts/:id.json');
	});

	app.factory('Splatt', function($resource) {
		return $resource('http://jones.sqrawler.com/api/splatts/:id.json');
	});


	app.factory('FollowUser', function($resource) {
		return $resource('http://jones.sqrawler.com/api/users/follows');
	});

	app.factory('UnFollowUser', function($resource) {
		return $resource('http://jones.sqrawler.com/api/users/follows/:id/:follows_id.json');
	});


		
	app.controller('UserController', function(User) {
	this.user = User.get({id:1});
	});





       	//---------------------------------------------------//
		//		           Create a new User                 //		
		//---------------------------------------------------//
		
		app.controller("AddUserController", function(User){
			this.data = {};
			this.createUser = function(user) {
				var dataName = this.data.name;
				var dataMail = this.data.email;
				var dataPassword = this.data.password;
				
			user = new User({name: dataName, email: dataMail, password: dataPassword});
			//user.$save();
			
			User.save(user,user);
			document.getElementById('prompt').innerHTML = "User Added";
			//this.user = User.save({name: dataName, email: dataMail, password: dataPassword});
				
				
			this.data = {}; // clears the form
			}
		});
		//---------------------------------------------------//

				
		//---------------------------------------------------//
		//		           Post a New Splatt                 //		
		//---------------------------------------------------//
		
		app.controller("NewSplattController", function(Splatt){
			this.data = {};
			this.newSplatt = function(splatt) {
				var dataUserID = this.data.userID;
				var dataMessage = this.data.message;
				
			splatt = new Splatt({body: dataMessage, user_id: dataUserID});
			//user.$save();
			
			Splatt.save(splatt,splatt);
			document.getElementById('prompt').innerHTML = "Splatt Posted";
			//this.user = User.save({name: dataName, email: dataMail, password: dataPassword});
				
				
			this.data = {}; // clears the form
			}
		});
		
		//---------------------------------------------------//
		
	
		//---------------------------------------------------//
		//		      Login a User using a User ID           //		
		//---------------------------------------------------//
		
		app.controller("FindUserController", function(User){
			this.data = {};
			var self = this;
			this.findUser = function() {
				var	dataUserID = parseInt(this.data.userid);
				self.user = User.get({id: dataUserID});
			}	
		});
		//---------------------------------------------------//

		
		//---------------------------------------------------//
		//		           View Splatts                      //		
		//---------------------------------------------------//
		
		app.controller("FindSplattsController", function(ViewSplatt,User){
			this.data = {};
			var self = this;
			this.findSplatts = function() {
				var	dataUserID = parseInt(this.data.userid);
				self.splatts = ViewSplatt.query({id: dataUserID});
				self.user = User.get({id: dataUserID});
			}
			
		});
		
		//---------------------------------------------------//
		
		

		
		//---------------------------------------------------//
		//		             Delete a User                   //		
		//---------------------------------------------------//
		
		app.controller("DeleteUserController", function(User){
			this.data = {};
			var self = this;
			this.DeleteUser = function() {
				var	deleteUserID = this.data.userDeleteID;
				self.user = User.remove({id: deleteUserID});
				document.getElementById('prompt').innerHTML = "User ID: " + deleteUserID + " Has been Deleted" ;
			}
			
		});
		
		//---------------------------------------------------//
		
		
		//---------------------------------------------------//
		//		             Follow a User                   //		
		//---------------------------------------------------//
		
		app.controller("followUserController", function(FollowUser){
			this.data = {};
			this.followUser = function(add_follows) {
				var dataUserID = this.data.userID;
				var dataFollowerID = this.data.followerID;

		
				
			add_follows = new FollowUser({id: dataUserID,follows_id: dataFollowerID});
			//user.$save();
			
			FollowUser.save(add_follows,add_follows);
		
			//this.user = User.save({name: dataName, email: dataMail, password: dataPassword});
				
				
			this.data = {}; // clears the form
			}
		});
		
		//---------------------------------------------------//
		
		
		//---------------------------------------------------//
		//		             Edit a User                   //		
		//---------------------------------------------------//
		
		app.controller("EditUserController", function(User){
			this.data = {};
			this.EditUser = function() {
				var dataUserID = this.data.userid;
				var dataName = this.data.name;
				var dataBlurb = this.data.blurb;
	
				User.update({id: this.data.userid}, {name: dataName, blurb: dataBlurb});

			this.data = {}; // clears the form
			}
		});
		
		//---------------------------------------------------//
		
		
		
		
		//---------------------------------------------------//
		//		          Un-Follow a User                   //		
		//---------------------------------------------------//
		
		app.controller("unfollowUserController", function(UnFollowUser){
			this.data = {};
			var self = this;
			this.unfollowUser = function() {
				var	UserID = this.data.userID;
				var FollowerID = this.data.followerID;

				self.unfollowUser = UnFollowUser.remove({id: UserID, follows_id: FollowerID});
				document.getElementById('prompt').innerHTML = "You have un-followed that user" ;
			}
			
		});

		

})();
