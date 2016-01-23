#v0.02
document.addEventListener 'keydown', (event) ->
	if event.keyCode is 13 
		event.preventDefault()
		save()
		initStories()

window.stories = []

window.storyNum = undefined

window.initStories = () =>
	window.storyNum = document.getElementById('storyCount').innerHTML

	for i in [0...storyNum]
		unless stories[i]? 
			newStory()
	loadStories()

window.calcTotal = () =>
	els = document.getElementsByClassName('est')

	str = ""
	for i in [0...storyNum]
		str += els[i].innerHTML
	time = parseTime(str)
	document.getElementById('total').innerHTML = timeToStr(time)

window.save = () =>
	
	el = document.getElementById('stories')
	els = el.getElementsByClassName('story')
	for i in [0...els.length]
		console.log els[i]
		stories[i] = """
		<div id='story_#{stories.length}' class="story">
			#{els[i].innerHTML}
		</div>
		"""


window.loadStories = () =>
	storiesElement = document.getElementById("stories")
	storiesElement.innerHTML = ""
	for i in [0...window.storyNum]
		storiesElement.innerHTML += """
		#{stories[i]}
		"""
	
window.copyToClipboard = (index) =>
	el = document.getElementById('stories')
	els = el.getElementsByClassName('story')
	story = els[index]
	user = story.getElementsByClassName('user')[0].innerHTML
	functionality = story.getElementsByClassName('functionality')[0].innerHTML
	benefit = story.getElementsByClassName('benefit')[0].innerHTML

	window.prompt "Copy to clipboard: Ctrl+C, Enter", "As a #{user}, I want #{functionality}, so that I can #{benefit}"

window.newStory = () =>
	s = """
	<div id='story_#{stories.length}' class="story">
		<p>As a<i class='user' contenteditable="true">user</i>, I want <i class='functionality' contenteditable="true">some functionality</i>, so that I can <i class='benefit' contenteditable="true">have some benefit</i>.
		<b>Estimate: <i class='est' contenteditable="true" spellcheck="false">0m</i></b>.
			<a href ="#" onClick= 'copyToClipboard(#{stories.length})' /><img class='clip' src='clipboard.jpg'></img></a>

		</p>
	</div>
	"""
	stories.push s

window.parseTime = (str) =>
	time = 
		hours : str.match /\d+h/g
		mins : str.match /\d+m/g
		days : str.match /\d+d/g
		weeks : str.match /\d+w/g
	return time

window.stripTime = (str) =>
	(str.match /\d/g).join ''

window.tallyTime = (time) =>
	total =
		hours:0
		mins:0
		days:0
		weeks:0

	if time.hours?
		for hour in time.hours 
			total.hours += parseInt(stripTime(hour))
	if time.mins?
		for min in time.mins
			total.mins += parseInt(stripTime(min))
	if time.days?
		for day in time.days
			total.days += parseInt(stripTime(day))
	if time.weeks?
		for week in time.weeks
			total.weeks += parseInt(stripTime(week))

	#minutes
	total.hours += Math.floor total.mins/60
	total.mins = total.mins % 60

	#hours
	total.days += Math.floor total.hours/8
	total.hours = total.hours % 8

	#days
	total.weeks += Math.floor total.days/5
	total.days = total.days % 5

	#weeks can accrue

	total

window.timeToStr = (time) =>
	tally = tallyTime time
	str = ""+["#{tally.weeks}w" if tally.weeks > 0]+[" #{tally.days}d" if tally.days > 0]+[" #{tally.hours}h" if tally.hours > 0]+[" #{tally.mins}m" if tally.mins > 0]
	str

setInterval(calcTotal,30)
initStories()