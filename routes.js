Router.configure({
  layoutTemplate: "layout"
});

Router.route("calendar", {
  path: "/",
  data: function () {
    return [];
  }
});
