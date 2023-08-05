open Yojson.Basic.Util

let maybe_read_line () = try Some (read_line ()) with End_of_file -> None

let rec loop acc =
  match maybe_read_line () with Some line -> loop (acc ^ line) | None -> acc

let json =
  (* 1 -> No arguments, then read from stdin
     2 -> Json file passed as first argument
     _ -> Error *)
  match Array.length Sys.argv with
  | 1 -> loop "" |> Yojson.Basic.from_string
  | 2 -> Yojson.Basic.from_file Sys.argv.(1)
  | _ -> raise (Failure "Usage: ./bios_checker bios_settings.json")

let attrib = json |> member "Attributes" |> to_assoc

let attrib_base =
  [
    ("DcuStreamerPrefetcher", `String "Enabled");
    ("DcuIpPrefetcher", `String "Enabled");
    ("DramRefreshDelay", `String "Performance");
    ("DynamicCoreAllocation", `String "Enabled");
    ("EnergyPerformanceBias", `String "MaxPower");
    ("IntelTxt", `String "Off");
    ("MemFrequency", `String "MaxPerf");
    ("MemPatrolScrub", `String "Disabled");
    ("NodeInterleave", `String "Disabled");
    ("ProcC1E", `String "Disabled");
    ("ProcCores", `String "All");
    ("ProcCStates", `String "Disabled");
    ("ProcPwrPerf", `String "MaxPerf");
    ("ProcTurboMode", `String "Disabled");
    ("ProcVirtualization", `String "Enabled");
    ("SriovGlobalEnable", `String "Enabled");
  ]

let union l1 l2 =
  (* Filter elements that are present in both lists (first element of the pair) and
     with different second pairs *)
  List.filter
    (fun x ->
      List.mem_assoc (fst x) l2
      && List.assoc (fst x) l1 <> List.assoc (fst x) l2)
    l1

let printelement e =
  print_string (fst e ^ " ");
  print_string (to_string (snd e) ^ "\n")

let () = List.iter printelement (union attrib attrib_base)
