module BillsGraph
  using JSON
  using DataFrames
  export Sponsor, graph, graph2csv, file2sponsor, loaddata, file2bill, billtitle

  type Sponsor
    name
    party
    id
    cosponsors
    Sponsor() = new()
  end

  function loaddata(dir)
    aux = []
    for entry in readdir(dir)
      entry = joinpath(dir,entry)
      if !isdir(entry)
        push!(aux,file2sponsor(entry))
      else
        append!(aux,loaddata(entry))
      end
    end
    aux
  end

  function nodes2csv(graph,file)
    nodes = DataFrame(ID = [], Label = [], Party = [])
    for s in graph
      push!(nodes, [int(s[1]) s[2].name s[2].party])
    end
    writetable(file,nodes)
  end

  function edges2csv(graph,file)
    _id = 1
    edges = DataFrame(Source = [], Target = [], Type = [], ID = [], Weight = [])
    for s in graph
      cosponsors = s[2].cosponsors
      for c in cosponsors
        push!(edges, [int(c.id) int(s[1]) "Directed" _id 1.0])
        _id += 1
      end
    end
    writetable(file,edges)
  end

  function graph(sponsors)
    graph = Dict()
    for s in sponsors
      if isdefined(s, :id)
        if haskey(graph, s.id)
          append!(graph[s.id].cosponsors, s.cosponsors)
        else
          graph[s.id] = s
        end
        for c in s.cosponsors
          get!(graph, c.id, c)
        end
      end
    end
    graph
  end

  function file2sponsor(file)
    sponsor = Sponsor()
    try
      dict = JSON.parsefile(file)
      println("JSON->Dict: $(file)")
      if haskey(dict,"sponsor") && !isempty(dict["sponsor"])
        sponsor.name = dict["sponsor"]["name"]
        sponsor.party = dict["sponsor"]["title"]
        sponsor.id = dict["sponsor"]["thomas_id"]
        sponsor.cosponsors = []
        for c in get(dict,"cosponsors", [])
          cosponsor = Sponsor()
          cosponsor.name = c["name"]
          cosponsor.party = c["title"]
          cosponsor.id = c["thomas_id"]
          cosponsor.cosponsors = []
          push!(sponsor.cosponsors,cosponsor)
        end
      end
    catch e
      warn("$(file) cannot be read")
      return
    end
    sponsor
  end
end
