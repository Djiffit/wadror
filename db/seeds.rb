b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

s1 = Style.create name:"Weizen", description:"Mieletöntä karjaisuo no usu neo ko ppawer"
s2 = Style.create name:"Lager", description:"Soppa syö soppa vie kukaan ei mahda mitään vaikka makaroonit on"
s3 = Style.create name:"Pale ale", description:"Hemmetti testien korjaamisessa tulee kestämään"
s4 = Style.create name:"IPA", description:"Hei hei ippaa ippaa jopaienen jokkaa"
s5 = Style.create name:"Porter", description:"Nistien suosimaa masteri korkeloa"

b1.beers.create name:"Iso 3", style:"Lager"
b1.beers.create name:"Karhu", style:"Lager"
b1.beers.create name:"Tuplahumala", style:"Lager"
b2.beers.create name:"Huvila Pale Ale", style:"Pale Ale"
b2.beers.create name:"X Porter", style:"Porter"
b3.beers.create name:"Hefeweizen", style:"Weizen"
b3.beers.create name:"Helles", style:"Lager"