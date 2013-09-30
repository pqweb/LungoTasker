class __Controller.TasksCtrl extends Monocle.Controller

    events:
      "click [data-action=new]"     :   "onNew"
     
    elements:
      "#pending"                    :   "pending"
      "#important"                  :   "important"
      "input"                       :   "name"

    constructor: ->
      super
      __Model.Task.bind "create",   @bindTaskCreated
      __Model.Task.bind "update",   @bindTaskUpdated
       @ChangeTotals

    onNew: (event) ->
      __Controller.Task.new()      

    bindTaskUpdated: (task) =>
      Lungo.Router.back()
      Lungo.Notification.hide()
      @ChangeTotals     

    bindTaskCreated: (task) =>
      context = if task.important is true then "high" else "normal"
      @view = new __View.Task model: task, container: "article##{context} ul"      
      Lungo.Router.back()
      Lungo.Notification.hide()
      @ChangeTotals

    ChangeTotals: ->
      #Control totals for tasks
      Lungo.Element.count "#headImportant", __Model.Task.important().length
      Lungo.Element.count "#important",     __Model.Task.important().length
      Lungo.Element.count "#headPending", __Model.Task.notImportant().length
      Lungo.Element.count "#pending",     __Model.Task.notImportant().length

$$ ->
  Lungo.init({})
  Tasks = new __Controller.TasksCtrl "section#tasks"

 