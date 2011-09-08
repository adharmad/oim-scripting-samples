(defn get-recon-map [userid]
  (doto (java.util.HashMap.)
    (.put "login" userid)
    (.put "first" (str userid "_First"))
    (.put "last" (str userid "_Last"))
    (.put "xltype" "End-User")
    (.put "role" "Full-Time")
    (.put "org" "Xellerate Users")))


(defn create-trusted-recon-event
  "Create a trusted recon event"
  [factory userid]
  (let [reconIntf (.getUtility factory "Thor.API.Operations.tcReconciliationOperationsIntf")]
    (do
      (def rceKey (.createReconciliationEvent reconIntf "Xellerate User" (get-recon-map userid) true))
      (println (format "Created recon event rcekey = %d" rceKey)))))

(defn create-trusted-recon-events
  "Creates trusted recon events"
  [factory prefix num]
  (dotimes [i num]
    (let [
      reconIntf (.getUtility factory "Thor.API.Operations.tcReconciliationOperationsIntf")
      userid (str prefix i)
    ]
      (do
        (def rceKey (.createReconciliationEvent reconIntf "Xellerate User" (get-recon-map userid) true))
        (println (format "Created recon event rcekey = %d" rceKey))))))

;; proxy that implements Runnable for creating recon events
(defn get-trusted-recon-proxy
  [factory prefix num]
  (proxy [Runnable] []
    (run []
      (let [
        reconIntf (.getUtility factory "Thor.API.Operations.tcReconciliationOperationsIntf")
        tid (.getName (Thread/currentThread))
      ]
        (dotimes [i num]
          (let [userid (str tid "_" prefix "_" i)]
            (do
              (def rcekey (.createReconciliationEvent reconIntf "Xellerate User" (get-recon-map userid) true))
              (println (format "Created recon event with userid %s and key %d" userid rcekey)))))))))

;; multi threaded trusted recon
(defn mt-trusted-recon
  [factory prefix numThreads numPerThread]
  (let [tarr (make-array Thread numThreads)]
    (do
      (dotimes [i numThreads]
        (aset tarr i (Thread. (get-trusted-recon-proxy factory prefix numPerThread))))
      (dotimes [i numThreads]
        (.start (aget tarr i)))
      (dotimes [i numThreads]
        (.join (aget tarr i))))))
