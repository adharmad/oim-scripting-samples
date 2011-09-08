;; deployment manager operations and functions
(load "xelconst")

(import '(java.io FileReader BufferedReader FileWriter BufferedWriter PrintWriter))

(defn clone-connector
  [template-file out-file subst-str new-str]
  (with-open [rdr (BufferedReader. (FileReader. template-file))
    pw (PrintWriter. (BufferedWriter. (FileWriter. out-file)) true)]
    (doseq 
      [line (line-seq rdr)]
      (let 
        [line-sub (.replaceAll line subst-str new-str)]
        (.println pw line-sub)))))

(defn import-file 
  "Imports a DM xml file"
  [factory filename]
  (let [impIntf (.getUtility factory IMP_INTF)]
    (do
      (.acquireLock impIntf true)
      (let [col (.addXMLFile impIntf filename (slurp filename))]
        (.performImport impIntf col)))))
