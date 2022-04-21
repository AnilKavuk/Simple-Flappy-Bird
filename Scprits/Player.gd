extends KinematicBody2D

const Up:Vector2=Vector2(0,-1)
const Flap:int=200
const MaxFallSpeed:int=200
const Gravity:int=10
var score:int=0

var Motion:Vector2=Vector2()

var Wall=preload("res://Scenes/WallNode.tscn")


func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	Motion.y+=Gravity
	if(Motion.y>MaxFallSpeed):
		Motion.y=MaxFallSpeed
	
	if(Input.is_action_just_pressed("Flap")):
		$wingSound.play()
		Motion.y=-Flap
	
	Motion=move_and_slide(Motion,Up)	
	
	
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text=str(score)
	
func Wall_Reset():
	print("passed")
	var Wall_instance=Wall.instance()
	Wall_instance.position=Vector2(rand_range(800,1024),rand_range(0,80))
	get_parent().call_deferred("add_child",Wall_instance)

func _on_Resetter_body_entered(body):
	if(body.name=="Walls"):
		print("Acces ")
		body.queue_free()
		Wall_Reset()


func _on_Detect_area_entered(area):
	if(area.name=="PointArea"):
		$pointSound.play()
		score+=1


func _on_Detect_body_entered(body):
	if(body.name=="Walls"):
		var _error=get_tree().change_scene("res://Scenes/GameOver.tscn")




func _on_BaseArea_body_entered(body):
	if(body.name=="Player"):
		var _error=get_tree().change_scene("res://Scenes/GameOver.tscn")
