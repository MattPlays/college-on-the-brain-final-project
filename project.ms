// Research Question: "How does stress affect performance in the classroom?"
// Throughout this program I will mention Stress and Sleep a ton-
// -as they are directly related to my research question.
// Sleep tends to occur when the ATP receptors in your brain are
// activated (Dingman, 2022, p. 66)
// Memory is the brain's way of making and keeping associations
// between things that happen in our daily lives, sometimes they are
// only in the brain for a short time (short-term memory) or the rest
// of our lives (long-term memory) (Dingman, 2022, p. 30)
// Stress is being used because it directly effects memory encoding-
// memory consolidation, and memory retrieval. (Vogel et al. 2016, p. 3)
// Students are often stressed by exams, tests, and other in-
// classroom events which can lead to strong negative memories
// (Vogel et al. 2016, p. 4) which actually inspired me to start 
// my quest on this research project because I was always 
// interested in different ways students could learn and still be 
// tested but not have their mental health depleted by getting 
// poor scores.
// People induced by stress can find tasks increasingly harder
// than when not stressed or in some cases when pain is involved
// stress can actually amplify the pain
// (Schwabe et al. 2009, p. 4)
import "events"
import "json"
import "mathUtil"
import "listUtil"
eventLoop = new events.eventLoop
Player = {}
Player.gender = "None"
Player.personality = "None"
Player.currStress = 3
// Starting stress can't be 0 because everyone is a little stressed
// Also if it was, nothing would progress in the game.
Player.currSleep = 10
Player.make = function(gender = "None")
	plr = new Player
	plr.gender = gender
	return plr
end function
clear
// There are different aspects that can affect memory consolidation when studying
// the environment, the length, and if there was stress before hand
// Stress before or during a learning episode can impact the initial encoding of the information
// and is closely linked to memory consolidation.
// (Vogel et al. 2016, p. 3)
pathways = json.parse(file.open("pathways.json").read).normalPathways
// Some pathways will have similar counterparts because
// "While stress around the time of learning enhances memory,
// stress (or cortisol administration of 25mg) long before learning
// or in a distinctly different context does not promote new learning
// and can even hinder successful encoding of new information"
// (Vogel et al. 2016, p. 3)
// This is also corroborated by "Stress effects on memory are time
// dependent, with stress before retention testing having mostly
// impairing effect" and that stress before retention testing specifically
// could actually enhance memory retrieval
// (Schwabe et al. 2009, p. 6)
// "Very often, students are not only required to recall study
// material, but to integrate new information into existing
// knowledge structures. In fact, integrating new information
// into existing memories is a key process in education."
// (Vogel et al. 2016, p. 4)
// This piece of information influenced the way I thought about
// creating this scenario because of the way it made me think about
// how people actually learn and recall information throughout the
// preparation of test studying.

// "Stressed subjects performed worse than nonstressed controls 
// when the learning and testing contexts were incongruent. 
// This is in line with previous reports of impaired memory 
// retrieval following stress" (Schwabe et al. 2009, p. 5)
// The results from this experiment definitively say that people
// who are stressed had a tougher time, this relates to my research
// and game because it replicates the results of the study in terms
// of the relationship between stress and memory

// Grab the pathways, make a copy, shuffle them and return 4
getNextPathwaySet = function
	copy = pathways.deepCopy
	copy.shuffle
	set = []
	for i in range(3)
		set.push copy.pull
	end for
	return set
end function
updateMeters = function(player)
	if not player then
		player = Player.make
	end if
	// Format stress level into a percentage
	print "Stress: "+player.currStress*10+"/100 " + " Sleep: "+player.currSleep*10+"/100"
end function
centerText = function(text)
	tl = text.len
	spaceEachSide = (67 - text.len) / 2
	print " " * spaceEachSide + text + " " * spaceEachSide
end function
makeBarrier = function
	print "="*67
end function
showWelcome = function
	centerText "Stress Simulator"
	centerText "Over the course of 3 days"
	centerText "You will need to maintain 2 meters"
	centerText "Stress below 60%"
	centerText "Sleep above 30%"
	print
	updateMeters
	makeBarrier
	centerText "On the next screen you will customize your character"
	makeBarrier
	input("Press any key to continue ")
end function
player = {}
customizePlayer = function
	centerText "Character Customization"
	print
	makeBarrier
	// Gender can be a factor in the way you perceive stress,
	// handle stress, and how much stress you can take.
	// however research isn't concrete on that so we won't actually
	// make any gender more preferable for the game but
	// gender will be included for inclusion.
	// (Vogel et al. 2016, p. 7)
	print "Gender:"
	print "1. Male"
	print "2. Female"
	print "3. Non-Binary"
	print "4. None"
	genderChoice = input("Please input your choice: ").val
	gender = "None"
	if genderChoice == 1 then
		gender = "Male"
	end if
	if genderChoice == 2 then
		gender = "Female"
	end if
	if genderChoice == 3 then
		gender = "Non-Binary"
	end if
	// Like gender, the research on personality having direct correlation
	// on stress is unfinished. However it will not be included in this game
	// because of the inconsistencies
	// (Vogel et al. 2016, p.7)
	outer.player = Player.make(gender)
end function
showEndScreen = function
	makeBarrier
	centerText "Test Time!"
	print
	print
	// The test will take place in the original environment like
	// the classroom rather than a different one
	// "Besides stress, another variable that influences our
	// memory is the context in which retention testing takes
	// place. Typically, individuals show better memory when
	// the learning environment is reinstated at test than when
	// testing occurs in a different environmental context"
	// (Schwabe et al. 2009, p. 1)
	// It is also mentioned that environment is important
	// "Although we focused mainly on the manipulation of the
	// environmental (i.e., external) context, it is important to note
	// that the presence or absence of stress can also be concep-
	// tualized as a change in internal context." (Schwabe et al 2009, p.5)
	// This reports that the findings of the article were dependent
	// on the environment.
	centerText "Location: Goodpaster 198"
	centerText "Time: 2:10pm"
	makeBarrier
	print
	print
	print
	// If player stress level is greater than 60% then we lose
	if player.currStress >= 6 then
		centerText "You were too stressed and forgot the test :O"
		centerText "You... LOSE"
		return
	end if
	// If player sleep level is less than 30% then we lose
	if player.currSleep <= 3 then
		centerText "Uh.. oh You were too tired and fell asleep during the test."
		centerText "You... LOSE"
		return
	end if
	scoreText = "You got a "
	// Compute score based on current stress and sleep levels
	score = mathUtil.clamp((rnd * 100) - (ceil(player.currStress / 2)) + (ceil(player.currSleep / 2)), 0, 100)
	scoreText += score
	scoreText += "%"
	centerText scoreText
	// If we get higher than a 60% then we win.
	if score >= 60 then
		centerText "You... WIN"
	else
		centerText "You... LOSE"
	end if
end function
showWelcome
clear
customizePlayer
day = 1
MAX_DAYS = 3
update = function
	clear
	if day == outer.MAX_DAYS then
		enventLoop.stop
		showEndScreen
	end if
	makeBarrier
	centerText "Day " + day
	updateMeters(player)
	paths = getNextPathwaySet
	for i in range(0, paths.len-1)
		path = paths[i]
		str = ""
		str += i+1 + ". "
		str += path.text
		if path.stressUp > 0 then str += " (Stress: +"+path.stressUp*10+"%)"
		if path.stressDown > 0 then str += " (Stress: -"+path.stressDown*10+"%)"
		if path.sleepUp > 0 then str += " (Sleep: +"+path.sleepUp*10+"%)"
		if path.sleepDown > 0 then str += " (Sleep: -"+path.sleepDown*10+"%)"
		print str
	end for
	pathChoice = input("Please choose a path: ").val
	path = paths[pathChoice-1]
	// If the players stress level is not 0 then make the changes
	// to the stress level
	if not player.currStress == 0 then
		player.currStress += path.stressUp
		player.currStress -= path.stressDown
	end if
	// If the players sleep level is not max then make the changes
	// to the sleep level
	if not player.currSleep == 10 then
		player.currSleep += path.sleepUp
		player.currSleep -= path.sleepDown
	end if
	outer.day += 1
end function
eventLoop.update = @update
eventLoop.run
// Works cited:
// Vogel, S., Schwabe, L. Learning and memory under stress: implications for the classroom. npj Science Learn 1, 16011 (2016). https://doi-org.
// proxy-sm.researchport.umd.edu/10.1038/npjscilearn.2016.11
// Schwabe, L., Wolf, O.T. The context counts: Congruent learning and testing environments prevent memory retrieval impairment following
// stress. Cognitive, Affective, & Behavioral Neuroscience 9, 229–236 (2009). https://doi-org.proxy-sm.researchport.umd.edu/10.3758/CABN.9.3.229
// Dingman, M. (2022). Your brain, explained: What neuroscience reveals about your brain and its quirks. London: Nicholas Brealey Publishing. 