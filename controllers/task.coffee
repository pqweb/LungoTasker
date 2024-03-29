class TaskCtrl extends Monocle.Controller

  elements:
    "input[name=name]"          : "name"
    "textarea[name=description]": "description"
    "select[name=list]"         : "list"
    "input[name=when]"          : "when"
    "input[name=important]"     : "important"

  events:
    "click [data-action=save]"  : "onSave"

  constructor: ->
    super
    @new = @_new
    @show = @_show

  # Events
  onSave: (event) ->
    if @current
      # Save
      @current.updateAttributes
        name        : @name.val(),
        description : @description.val(),
        list        : @list.val(),
        when        : @when.val(),
        important   : @important[0].checked
    else
      # New task
      if @name.val() != ""
        Lungo.Notification.show()
        __Model.Task.create
          name        : @name.val()
          description : @description.val()
          list        : @list.val()
          when        : @when.val()
          important   : @important[0].checked

  # Private Methods
  _new: (@current=null) ->
    @name.val ""
    @description.val ""
    @list.val ""
    @when.val ""
    Lungo.Router.section "task"

  _show: (@current) ->
    @name.val @current.name
    @description.val @current.description
    @list.val @current.list
    @when.val @current.when
    @important.val @current.important
    Lungo.Router.section "task"

  
$$ ->
  __Controller.Task = new TaskCtrl "section#task"
