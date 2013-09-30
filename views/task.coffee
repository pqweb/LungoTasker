class __View.Task extends Monocle.View

  template  : """
    <li>
      <span class="icon {{#done}}ok{{/done}}"></span>
      <div class="on-right">{{list}}</div>
      <strong>{{name}}</strong>
      <small>{{description}}</small>
    </li>
  """

  constructor: ->
    super
    __Model.Task.bind "update", @bindTaskUpdated
    @append @model

  events:
    "swipeLeft li"  :  "onDelete"
    "hold li"       :  "onDone"
    "singleTap li"  :  "onView"

  elements:
    "input.toggle"             : "toggle"

  onDone: (event) ->
    @model.updateAttributes done: !@model.done
    @refresh()
    console.log (event);
    
  onDelete: (event) =>
    confirm = ->
      if confirm("¿are you sure?") true  else  false

  bindTaskUpdated: (task) =>
      #the task control according to the article to which it belongs
      if task.uid is @model.uid
          @model = task
          content = null
      if @container.selector is "article#normal ul" 
          content = "high"
      else if @container.selector is "article#high ul" 
          content = "normal"
      #assign task to the container
      if content? @remove()        
          @container = Monocle.Dom("article#" + content + " ul")
          Monocle.Dom("article#" + content + " ul").append(@element)
          @refresh()

  onView: (event) ->
    __Controller.Task.show @model