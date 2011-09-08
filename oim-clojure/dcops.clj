(load "xelconst")

(defn start-dc
  "Begin a new data collection session"
  [factory sid emap]
  (let [
    dcIntf (.getUtility factory DC_INTF)
    ]
    (.startDataCollection dcIntf sid (java.util.HashMap. emap))))

(defn get-dc-status
  "Get data collection status"
  [factory sid]
  (let [
    dcIntf (.getUtility factory DC_INTF)
    ]
    (.getDataCollectionStatus dcIntf sid)))

(defn finalize-dc
  "Finalize data collection status"
  [factory sid]
  (let [
    dcIntf (.getUtility factory DC_INTF)
    ]
    (.finalizeDataCollectionSession dcIntf sid)))
