extends Reference
class_name NameGenerator

#This list is *most* of those represented in F1's history. Some political sinkholes have been avoided, i.e. Rhodesia -> Zimbabwe and East/West Germany
#Also included a couple new-world distinctions for Canada and Brasil
#If this becomes a period piece, it would be cool and artsy to reflect that in the nationalities, since big racing has always been political...food for thought!
var nationalities: PoolStringArray = ["Argentina", "Australia", "Austria", "Belgium", "Brazil", "Canada-English", "Canada-French", "Chile", "China", "Columbia", "Czech Republic", "Denmark", "Finland", "France", "Germany",
"Hungary", "India", "Indonesia", "Ireland", "Italy", "Japan", "Malaysia", "Mexico", "Monaco", "Morocco", "Netherlands", "New Zealand", "Poland", "Portugal", "Russia",
"South Africa", "Spain", "Sweden", "Switzerland", "Thailand", "United Kingdom", "United States", "Uruguay", "Venezuela"]


func get_nationality() -> String:
	#Todo: weighting system for the nationalities?
	var random_int = randi() % nationalities.size()
	var nationality = nationalities[random_int]
	return nationality


func get_driver_name(input_nationality: String = "United States") -> String:
	#big switch statement for the different languages
	#Assuming for now names are similar enough between regions with same language
	#Also assuming countries have one language
	#Also assuming...all men! Another artsy thing to touch on in the actual game.
	#Todo: don't assume that! ex: Ireland, or Switzerland
	var name: String
	var random_int_01: int
	var random_int_02: int
	var first_name_table: PoolStringArray
	var last_name_table: PoolStringArray
	
	#Digusting switch statement where we just...list all possible first and last names
	match(input_nationality):
		#English
		"Australia", "Canada-English", "Ireland", "New Zealand", "United Kingdom", "United States":
			first_name_table = ["James", "Michael", "Robert", "John", "David", "William", "Richard", "Thomas", "Mark", "Charles", "Stephen", "Gary", "Joseph", "Donald", "Kenneth", "Paul", "Larry",
			"Daniel", "Dennis", "Timothy", "Edward", "Jeffrey", "George", "Gregory", "Kevin", "Douglas", "Terry", "Anthony", "Scott"]
			last_name_table = ["Smith", "Jones", "Williams", "Taylor", "Brown", "Davies", "Evans", "Wilson", "Johnson", "Robinson", "Wright", "Thompson", "Walker", "White", "Green", "Hall", "Clarke",
			"Jackson", "Hill", "Turner", "Edwards", "Harris", "Ward", "Hughes", "Moore", "Lee", "Morris", "Phillips", "Mitchell", "Hardin", "Cook", "Collins", "Marshall"]
		
		#Spanish
		"Argentina", "Chile", "Columbia", "Mexico", "Spain", "Uruguay", "Venezuela":
			first_name_table = ["Jos??", "Antonio", "Juan", "Francisco", "Pedro", "Manuel", "Miguel", "Luis", "??ngel", "Jes??s", "Rafael", "Javier", "Carlos", "Alberto", "Sergio", "Alberto"]
			last_name_table = ["Garcia", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Perez", "Sanchez", "Fernandez", "Martin", "Ruiz", "Diaz", "Mu??oz", "Alvarez", "Romero", "Alonso",
			"Navarro", "Torres", "Dominguez", "Ramos", "Blanco", "Ortega", "Delgado", "Rubio", "Iglesias", "Medina", "Castillo", "Cortes", "Herrera", "Flores", "Leon", "Pe??a"]
		
		#French
		"Canada-French", "Monaco", "France":
			first_name_table = ["Jean", "Michel", "Claude", "Dominique", "Charles", "Francis", "Philippe", "Bernard", "Pierre", "Alain", "Andre", "Jacques", "Christian", "Christophe", "Laurent",
			"Pascal", "Rene", "Joseph", "Olivier", "Nicolas", "David", "Roger", "Jean-Claude", "Bruno", "Marcel", "Yves", "Georges", "Julien", "Henri"]
			last_name_table = ["Martin", "Bernard", "DuBois", "Moreau", "Simon", "Laurent", "Durand", "David", "Roux", "Fournier", "Lambert", "Blanc", "DuPont", "Morin", "Rousseau", "Vincent", "Chevalier",
			"Blanchard", "Gauthier", "Vidal", "Fontaine"]
		
		#Moroccan French
		"Morocco":
			first_name_table = ["Mohammed", "Ahmed", "Youssef", "Rachid", "Hassan", "Mustapha", "Hicham", "Khalid", "Yassine", "Omar", "Abdellah", "Brahim", "Amine", "Hamza", "Driss", "Hamid", "Karim"]
			last_name_table = ["Ait", "Alaoui", "Alami", "Bennani", "Idrissi", "Berrada", "Lahlou", "Tazi", "El Idrissi", "Benjelloun", "Saidi", "Tahiri", "Aziz", "El Mostafa", "Amrani", "Naji",
			"El Alami", "Drissi", "Sabri", "Said"]
		
		#German
		"Austria", "Germany", "Switzerland":
			first_name_table = ["Friedrich", "Peter", "Michael", "Wolfgang", "Thomas", "Klaus", "Werner", "Manfred", "Hans", "Heinz", "Andreas", "J??rgen", "Helmut", "Gerhard", "G??nter", "Josef",
			"Frank", "Walter", "Bernd", "Karl", "Stefan", "Franz", "Georg", "Heinrich", "Hermann", "Kurt", "Siegfried", "Rainer", "Joachim", "Rolf", "Norbert", "Wilhelm", "Markus", "Alfred", "Alexander", "Ulrich"]
			last_name_table = ["M??ller", "Schmidt", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann", "Koch", "Richter", "Bauer", "Sch??fer", "Klein", "Wolf", "Schr??der",
			"Neumann", "Schwarz", "Braun", "Zimmermann", "Kr??ger", "Schulze", "Mayer", "K??nig", "Huber", "Lang", "Weiss", "Hahn", "Vogel", "Voigt", "Schubert", "Roth", "Lorenz"]
		
		#Italian
		"Italy":
			first_name_table = ["Giuseppe", "Giovanni", "Antonio", "Francesco", "Luigi", "Mario", "Salvatore", "Vincenzo", "Roberto", "Paolo", "Marco", "Angelo", "Domenico", "Pietro", "Franco",
			"Alessandro", "Carlo", "Stefano", "Massimo", "Nicola", "Giorgio", "Bruno", "Maurizio", "Luciano", "Luca", "Pasquale", "Fabio", "Claudio", "Raffaele", "Giancarlo", "Alfonso"]
			last_name_table = ["Rossi", "Russo", "Esposito", "Colombo", "Bianchi", "Romano", "Ricci", "Gallo", "Dal", "Bruno", "Greco", "Marino", "Conti", "Giordano", "Rizzo", "de Luca", "Costa",
			"Mancini", "Lombardi", "Barbieri", "Fontana", "Moretti", "Mariani", "Caruso", "Galli", "Santoro", "Rinaldi", "D'Angelo", "Bianco", "Martinelli", "Gatti", "Vitale", "Coppola", "Diamonte"]
		
		#Dutch
		"Belgium", "Netherlands":
			first_name_table = ["Jan", "Peter", "Hans", "Henk", "Paul", "Jeroen", "Marcel", "Erik", "Wim", "Johan", "Rene", "Martijn", "Frans", "Willem", "Michel", "Maarten", "Joost", "Dirk",
			"Rik", "Arjen", "Roland", "Evert", "Max", "Guus", "Hugo", "Sebastiaan", "Luc", "Rogier"]
			last_name_table = ["de Jong", "Jansen", "de Vries", "Bakker", "Janssen", "van Dijk", "Visser", "Smit", "de Boer", "de Groot", "Mulder", "Meijer", "Bos", "Peters", "van der Berg",
			"Hendriks", "Dekker", "van Leeuwen", "Brouwer", "Dijkstra", "de Wit", "de Graaf", "Jacobs", "de Haan", "Schouten", "de Bruin", "Koster"]
		
		#European Portuguese
		"Portugal":
			first_name_table = ["Pedro", "Ant??nio", "Jo??o", "Paulo", "Jos??", "Carlos", "Luis", "Jorge", "Ricardo", "Fernando", "Manuel", "Tiago", "Bruno", "Francisco", "Hugo", "Filipe", "Joaquim",
			"Andr??", "Marco", "Diogo", "Daniel", "Raquel", "M??rio", "Alexandre", "Gon??alo", "Alberto", "Henrique", "Rodrigo"]
			last_name_table = ["Silva", "Santos", "Ferreira", "Pereira", "Costa", "Oliveira", "Martins", "Rodrigues", "Sousa", "Fernandes", "Lopes", "Gon??alves", "Marques", "Gomes", "Ribeiro",
			"Pinto", "Alves", "Dias", "Teixeira", "Mendes", "Monteiro", "Cardoso", "Duarte", "Nunes"]
		
		#Brazilian Portuguese
		"Brazil":
			first_name_table = ["Pedro", "Ant??nio", "Jo??o", "Paulo", "Jos??", "Carlos", "Luis", "Jorge", "Ricardo", "Fernando", "Pedro", "Francisco", "Marcos", "Rafael", "Sebastiao", "Matheus", "Guilherme",
			"Felipe", "Gustavo", "Joaquim", "Simon", "Ronaldo", "Henrique"]
			last_name_table = ["da Silva", "Silva", "dos Santos", "Pereira", "Alves", "Ferreira", "Rodrigues", "de Oliveira", "de Souza", "Gomes", "Santos", "Oliveira", "Ribeiro", "de Jesus", "Soares",
			"Barbosa", "Lima", "Batista", "Fernandes", "Costa", "da Concei??ao"]
		#Czech
		"Czech Republic":
			first_name_table = ["Jan", "Petr", "Ji????", "Josef", "Pavel", "Martin", "Michal", "Franti??ek", "Tomas", "Jakub", "Karel", "David", "Lukas", "Roman", "Stanislav", "Filip", "Dominik",
			"Patrik", "Jind??ich", "Milo??"]
			last_name_table = ["Nov??kov??", "Nov??k", "Svobodov??", "Svoboda", "Novotn??", "Ctvrtlik", "Tydlacka", "Dvo????kov??", "??ern??", "Proch??zkov??", "Ku??era", "Hor??kov??", "Marek", "Posp????il", "Bene??", "Kr??l"]

		#Danish
		"Denmark":
			first_name_table = ["Peter", "Lars", "Jens", "Michael", "Henrik", "Thomas", "Mette", "Jan", "Niels", "S??ren", "Jesper", "Hans", "Martin", "J??rgen", "Anders", "Christian", "Erik", "Claus", "Torben",
			"Flemming", "Carl", "Finn", "Knud", "Kurt", "Kasper", "Jakob", "Tove", "Jonas", "Andreas"]
			last_name_table = ["Jensen", "Nielsen", "Hansen", "Pedersen", "Andersen", "Christensen", "Larsen", "S??rensen", "Rasmussen", "J??rgensen", "Madsen", "Kristensen", "Olsen", "Thomsen", "Poulsen",
			"Knudsen", "M??ller", "Knudsen", "Lund", "Holm", "Frederiksen", "Schmidt", "Clausen", "Dahl", "Vestergaard", "Jespersen", "Bruun", "Friis", "Bach", "N??rgaard"]

		#Swedish
		"Sweden":
			first_name_table = ["Lars", "Karl", "Hans", "Nils", "Sven", "Erik", "Johan", "Anders", "Leif", "Ulf", "Bj??rn", "Kjell", "Rolf", "Fredrik", "Martin", "Magnus", "Claes", "Jens", "Simon",
			"G??ran", "Tomas", "Bernt", "Arne", "Gustav", "Gunnar", "Tobias", "Anton", "Jesper", "Knut", "Rune", "Max", "Oskar", "Markus", "Linus", "Ernst"]
			last_name_table = ["Johansson", "Andersson", "Karlsson", "Nilsson", "Eriksson", "Larsson", "Olsson", "Pettersson", "Lindberg", "Lindstr??m", "Lindgren", "Magnusson", "Berg", "Jakobsson",
			"Bergstr??m", "Sandberg", "Forsberg", "Lindqvist", "Eklund", "Sj??berg", "Engstr??m", "H??kansson", "Bergman", "Fransson", "S??derberg"]

		#Hungarian
		"Hungary":
			first_name_table = ["L??szl??", "Istv??n", "J??zsef", "Zolt??n", "S??ndor", "Peter", "Andr??s", "Gy??rgy", "Mikl??s", "P??l", "K??lm??n", "Roland", "Viktor", "M??ty??s"]
			last_name_table = ["T??th", "Nagy", "Szab??", "Kov??cs", "Varga", "Horv??th", "Moln??r", "N??meth", "Farkas", "Tak??cs", "Balogh", "Simon", "Sz??cs", "Szil??gyi", "M??sz??ros"]

		#Polish
		"Poland":
			first_name_table = ["Piotr", "Tomasz", "Marcin", "Krzysztof", "Andrzej", "Grzegorz", "Adam", "Mariusz", "Wojciech", "Jakub", "Jan", "Lukasz", "Daniel", "Jerzy", "Rafal", "Konrad"]
			last_name_table = ["Nowak", "Kowalski", "Lewandowski", "Kami??ski", "Zieli??ski", "Koz??owski", "Jankowski", "Mazur", "Krawczyk", "Dudek", "Zaj??c", "Sikora"]

		#Russian
		"Russia":
			first_name_table = ["Sergey", "Aleksandr", "Andrey", "Vladimir", "Aleksey", "Ivan", "Alexander", "Nikolai", "Mikhail", "Pavel", "Roman", "Igor", "Anton", "Nikita", "Oleg", "Ilya", "Viktor",
			"Konstantin", "Artyom", "Yuri", "Vitaliy", "Daniil", "Maxim", "Georgiy", "Grigoriy", "Boris"]
			last_name_table = ["Ivanov", "Kuznetsov", "Petrov", "Smirnova", "Popov", "Volkova", "Pavlova", "Romanova", "Novikov", "Makarova", "Sergeeva", "Zaytseva", "Stepanova",
			"Zakharov", "Zhukov", "Savchenko", "Aleksandrovich", "Vasilenko"]

		#Chinese
		"China":
			first_name_table = ["Wei", "Yan", "Li", "Ying", "Hui", "Lei", "Hong", "Yu", "Min", "Xin", "Bin", "Yong", "Ming", "Chao", "Xiohong", "Yuan", "Song", "Han", "Lihong", "Jianwei",
			"Yin", "Wenjie", "Qinghua", "Guo", "Zhang", "Lifang"]
			last_name_table = ["Wang", "Li", "Zhang", "Liu", "Chen", "Yang", "Huang", "Wu", "Xu", "Zhao", "Zhou", "Lu", "Zhu", "Sun", "He", "Ma", "Yu", "Hu", "Guo", "Jiang", "Luo", "Gao",
			"Shi", "Wei", "Xie", "Song", "Feng", "Yan", "Deng", "Han", "Cao", "Tan", "Ceng", "Xiao", "Cai", "Cheng", "Bao", "Zhan", "Quio"]

		#Japanese
		"Japan":
			first_name_table = ["Kenji", "Hiroshi", "Toshio", "Yoshio", "Akira", "Kiyoshi", "Takashi", "Hideo", "Koji", "Takeshi", "Tadashi", "Shoji", "Hiroyuki", "Isamu", "Takeo", "Yuji", "Kachi",
			"Tatsuo", "Seiji", "Ichiro", "Toru", "Saburo", "Junichi", "Yoshinori", "Masato", "Shinobu", "Hideaki", "Keiji", "Takayuki", "Jiro", "Sho", "Yuichi", "Tetsuya", "Kazuyuki"]
			last_name_table = ["Sato", "Suzuki", "Tanaka", "Watanabe", "Takahashi", "Ito", "Yamamoto", "Nakamura", "Kobayashi", "Saito", "Kato", "Yoshida", "Yamada", "Sasaki", "Matsumoto", "Yamaguchi",
			"Inoue", "Kimura", "Shimizu", "Hayashi", "Abe", "Ono", "Mori", "Nakajima", "Hashimoto", "Yamazaki", "Ishikawa", "Ogawa", "Ishii", "Kawamura", "Kono", "Noguchi", "Takeda", "Ito", "Muraki"]

		#Hindi? India has lots of languages
		"India":
			first_name_table = ["Sanjay", "Santosh", "Sunil", "Rajaesh", "Ramesh", "Ashok", "Vijay", "Abdul", "Raju", "Vinod", "Raj", "Dinesh", "Rakesh", "Ajay", "Mukesh", "Shankar", "Ravi", "Ganesh",
			"Gopal", "Arun", "Prakash", "Rahul", "Mahendra", "Narayan", "Pradip", "Umesh", "Amar", "Sudhir", "Govind", "Jay"]
			last_name_table = ["Devi", "Singh", "Kumar", "Das", "Kaur", "Ram", "Yadav", "Kumari", "Lal", "Bai", "Khatun", "Mandal", "Ali", "Sharma", "Ray", "Mondal", "Sah", "Patel", "Prasad", "Ghosh",
			"Sahu", "Raut", "Shaik", "Bauri", "Solanki", "Prakash", "Pandey", "Patal", "Parambil", "Dhananjayan"]

		#Indonesian
		"Indonesia":
			first_name_table = ["Muhammad", "Ahmad", "Agus", "Abdul", "Asep", "Slamet", "Edi", "Dede", "Budi", "Ali", "Wayan", "Bambang", "Achmad", "Imam", "Adi", "Iwan", "Moch", "Rudi", "Yusuf", "Irwan"]
			last_name_table = ["Sari", "Setiawan", "Hidayat", "Lestari", "Saputra", "Wati", "Rahayu", "Dewi", "Kurniawan", "Santoso", "Putra", "Susanti", "Wahyuni", "Ningsih", "Susanto", "Gunawan"]

		#Thai
		"Thailand":
			first_name_table = ["Somchai", "Prasoet", "Somsak", "Prasit", "Sombat", "Udom", "Thawi", "Charoen", "Samran", "Wichai", "Somphong", "Pricha", "Wirat", "Somuek", "Wanchai", "Somkiat", "Saman", "Phon"]
			last_name_table = ["Saetang", "Chen", "Saelim", "Nguyen", "Bunmi", "Sukkasem", "Sangthong", "Chanthara", "Suwan", "Lim", "Sitwat", "Rungrueang", "Ayutthaya", "Sisuk", "Chaichana", "Saelao"]

	
	#The real meat: add a random value from each table together, and voila!
	random_int_01 = randi() % first_name_table.size()
	random_int_02 = randi() % last_name_table.size()
	
	#To prevent repeating names like "Li Li" (Chinese) or "Said Said" (Moroccan)
	while(first_name_table[random_int_01] == last_name_table[random_int_02]):
		random_int_02 = randi() % last_name_table.size()
	
	name = first_name_table[random_int_01] + " " + last_name_table[random_int_02]
	print("Name generated for nationality " + input_nationality + ": " + name)
	
	return name
