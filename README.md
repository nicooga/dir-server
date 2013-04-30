dir-server
==========

This is a simple Rack app for serving static files under a given directory. It consists of a couple of basic elements:

+ **/dir_server.rb:** call this script with DIRECTORY and PASSWORD.
+ **/controllers/router.rb:** this is a bare bones router. It yields a `Routes` object whch comes equiped with `#draw`. Use this method with 4 arguments: http_method, pattern, controller and action (just a method difined inside the controller)
+ **/controllers/*:** controllers inherit from `ControllerBase`.
+ **/views/*:** haml views are stored here and rendered with `render :view_name` or `render 'view_name'`.
