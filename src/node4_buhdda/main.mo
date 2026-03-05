import Time "mo:base/Time";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Int "mo:base/Int";

actor Node4Buhdda {

  let NODE_ID      : Text = "buhdda-genesis-validator-4";
  let NODE_NAME    : Text = "BUHDDA";
  let NODE_PURPOSE : Text = "Founder Personal Node + Governance & Emergency Powers";
  let FOUNDER_PRINCIPAL : Text = "26hy7-w7xyn-j3o6v-6nzuw-pm5e3-ahc2m-4a6ns-u5vdn-wn6vr-yinws-4ae";
  let PAYOUT_DEST  : Text = "exchange-wallet";

  var isActive      : Bool = true;
  var networkPaused : Bool = false;
  var totalRewards  : Nat  = 0;
  var heartbeatCount: Nat  = 0;
  var startTime     : Int  = Time.now();
  var lastHeartbeat : Int  = Time.now();
  var statusMessage : Text = "BUHDDA Node 4 — Online and governing";

  system func heartbeat() : async () {
    heartbeatCount += 1;
    lastHeartbeat := Time.now();
  };

  public shared(msg) func emergencyPause(reason : Text) : async Text {
    assert(Principal.toText(msg.caller) == FOUNDER_PRINCIPAL);
    networkPaused := true;
    statusMessage := "EMERGENCY PAUSE: " # reason;
    return "Network paused: " # reason;
  };

  public shared(msg) func emergencyResume() : async Text {
    assert(Principal.toText(msg.caller) == FOUNDER_PRINCIPAL);
    networkPaused := false;
    statusMessage := "BUHDDA Node 4 — Online and governing";
    return "Network resumed";
  };

  public shared(msg) func recordReward(amount : Nat) : async Text {
    assert(Principal.toText(msg.caller) == FOUNDER_PRINCIPAL);
    totalRewards += amount;
    return "Reward recorded: " # Int.toText(amount);
  };

  public query func getStatus() : async {
    nodeId: Text; nodeName: Text; isActive: Bool;
    networkPaused: Bool; totalRewards: Nat;
    heartbeats: Nat; status: Text; payoutDest: Text;
  } {
    { nodeId = NODE_ID; nodeName = NODE_NAME;
      isActive = isActive; networkPaused = networkPaused;
      totalRewards = totalRewards; heartbeats = heartbeatCount;
      status = statusMessage; payoutDest = PAYOUT_DEST; }
  };

  public query func getNodeInfo() : async Text {
    NODE_NAME # " | " # NODE_PURPOSE # " | Active: YES"
  };
}
