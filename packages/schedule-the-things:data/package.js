Package.describe({
  name: "schedule-the-things:data",
  summary: "",
  version: "0.1.0",
  git: "https://github.com/chicagogrooves/meteor-data"
});

Package.onUse(function(api) {
  api.versionsFrom("1.0.1");
  api.use(["meteor", "ddp", "mongo", "underscore"]);

  api.addFiles("shared/collections.js", ["client", "server"]);
  api.addFiles("client/subscriptions.js", ["client"]);
  api.addFiles("server/publications.js", ["server"]);

  api.export("Subscriptions", "client");
  api.export("Publications", "server"); // TODO - can we actually stop a pub or is it per-client?
  api.export("Collections");
});

Package.onTest(function (api) {
  api.use("tinytest");
  api.use("schedule-the-things:data");

  api.addFiles("tests/shared/index.js", ["client", "server"]);

});
