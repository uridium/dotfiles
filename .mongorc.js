var states = ["STARTUP", "PRIMARY", "SECONDARY", "RECOVERING", "FATAL",
              "STARTUP2", "UNKNOWN", "ARBITER", "DOWN", "ROLLBACK"];

prompt = function() {
    var host = db.serverStatus().host;
    var setName = rs.status().set;
    result = db.isMaster();
    if (result.ismaster && !result.setName) {
        dbState = 'STANDALONE';
    } else if (result.secondary) {
        dbState = 'SECONDARY';
    } else {
        result = db.adminCommand({replSetGetStatus : 1});
        dbState = states[result.myState];
    }
    return host + ' [' + setName + ':' + dbState + '] ' + db + '> ';
}
