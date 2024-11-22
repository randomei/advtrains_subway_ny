local S = minetest.get_translator "advtrains_subway_ny"


advtrains.register_wagon("NY_lokomotive", {
	mesh="advtrains_engine_ny.b3d",
	textures = {"advtrains_engine_ny.png"},
	is_locomotive=true,
	drives_on={default=true},
	max_speed=15,
	seats = {
		{
			name=S("Driver Stand (Left)"),
			attach_offset={x=-2.8, y=-1, z=18},
			view_offset={x=0, y=-3, z=10},
			driving_ctrl_access=true,
			group = "dstand",
		},
		{
			name="1",
			attach_offset={x=-4, y=-3, z=8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="2",
			attach_offset={x=4, y=-3, z=8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="3",
			attach_offset={x=-4, y=-3, z=-8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="4",
			attach_offset={x=4, y=-3, z=-8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
	},
	seat_groups = {
		dstand={
			name = S("Driver Stand"),
			access_to = {"pass"},
			driving_ctrl_access=true,
			require_doors_open=true,
		},
		pass={
			name = S("Passenger Area"),
			access_to = {"dstand"},
			require_doors_open=true,
		},
	},
	assign_to_seat_group = {"dstand", "pass"},
	doors={
		open={
			[-1]={frames={x=0, y=20}, time=1},
			[1]={frames={x=40, y=60}, time=1}
		},
		close={
			[-1]={frames={x=20, y=40}, time=1},
			[1]={frames={x=60, y=80}, time=1}
		}
	},
	visual_size = {x=1, y=1},
	wagon_span=2.3,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,2.5,1.0},
	update_animation=function(self, velocity)
		if self.old_anim_velocity~=advtrains.abs_ceil(velocity) then
			self.object:set_animation({x=1,y=80}, advtrains.abs_ceil(velocity)*15, 0, true)
			self.old_anim_velocity=advtrains.abs_ceil(velocity)
		end
	end,


	drops={"advtrains:NY_lokomotive"},
    custom_on_velocity_change = function(self, velocity, old_velocity, dtime)
		if not velocity or not old_velocity then return end
		if old_velocity == 0 and velocity > 0 then
			minetest.sound_play("ny_subway_throttle", {object = self.object})
		end
	end
}, S("NY Subway Engine"), "advtrains_engine_ny_inv.png")

advtrains.register_wagon("ny_wagon", {
	mesh="advtrains_wagon_ny.b3d",
	textures = {"advtrains_engine_ny.png"},
	drives_on={default=true},
	max_speed=15,
	seats = {
		{
			name="1",
			attach_offset={x=-4, y=-3, z=8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="2",
			attach_offset={x=4, y=-3, z=8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="1a",
			attach_offset={x=-4, y=-3, z=0},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="2a",
			attach_offset={x=4, y=-3, z=0},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="3",
			attach_offset={x=-4, y=-3, z=-8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
		{
			name="4",
			attach_offset={x=4, y=-3, z=-8},
			view_offset={x=0, y=-4, z=0},
			group="pass",
		},
	},
	seat_groups = {
		pass={
			name = S("Passenger Area"),
			access_to = {},
			require_doors_open=true,
		},
	},
	assign_to_seat_group = {"pass"},
	doors={
		open={
			[-1]={frames={x=0, y=20}, time=1},
			[1]={frames={x=40, y=60}, time=1}
		},
		close={
			[-1]={frames={x=20, y=40}, time=1},
			[1]={frames={x=60, y=80}, time=1}
		}
	},
	door_entry={-1, 1},
	visual_size = {x=1, y=1},
	wagon_span=2.3,
	collisionbox = {-1.0,-0.5,-1.0, 1.0,2.5,1.0},
	drops={"advtrains:ny_wagon"},
}, S("NY Subway Wagon"), "advtrains_wagon_ny_inv.png")


