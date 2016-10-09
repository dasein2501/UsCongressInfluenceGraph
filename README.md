# Us Congress Influence Graph.

Being a huge fan of House of Cards Netflix Original Series, I decided to look for the “real” Frank Underwood in the 113o US Congress. The main idea is to create a graph based on the congressmen in the House of Representatives (Congress). This graph has as a nodes the congressmen that has sponsored or cosponsored a bill, and the relationaships between the nodes are congressmen that have cosponsored the law, that is, if one congressmen sponsor a law and that law is cosponsored by other congressmen, that congressmen are followers of the congressmen that sponsored the law, which becomes our leader.
For this purpouse, I have taken the data of bills in the house of representatives for the 113o congress of the United States of America (https://github.com/unitedstates/congress/wiki/bills).

## Cleaning the data.
The dataset came in JSON format so I decided to convert it to CSV in order to loaded into Gephi. I created a script in Julia called BillsGraph.jl that extracts the sponsors and cosponsors from the JSON and creates a graph. Then, you can export that graph to CSV format in the form of a file of nodes and another file of edges, which can be leater loaded to Gephi easily. So I created a nodes.csv and edges.csv file that I loaded to Gephi to créate the graph.

## Analysis in Gephi.
Once the data is loaded to Gephi, a graph of 447 nodes and 101549 edges is created. I run a PageRank in order to finde the most relevant congressmen and then, I filtered the resulting graph by a range based in the nodes with the highest PageRank. I modified the layout of the graph expanding it and using Force Atlas. Then, I increased the size of the nodes based in the PageRank and I gave then a gradient of red color based in the Betweeness Centrality to find the most influencial congressmen among them. Finally, I assigned as labels the name of the congressman.

## And the winner is...
Jeff Miller! As we can see in the graph, Jeff Miller is the biggest node and more central also (color intensity) that means that he is a proactive lawmaker and lead most of the laws, but also means that maybe that kind of leadership is alligned with its party, since he is present in the centrality of the lawmaking which places him in the sponsor and cosponsorship of many laws. In fact, thats what states his Wikipedia entry in the political position: “Miller typically votes along Republican party lines.” https://en.wikipedia.org/wiki/Jeff_Miller_(Florida_politician).

![alt text](https://github.com/mrquant/UsCongressInfluenceGraph/blob/master/graph/congress_graph.png "Congress Graph")
