class "sJetpack"

function sJetpack:__init()
	self:initMessages()
	Events:Subscribe("PlayerChat", self, self.onPlayerChat)
end

function sJetpack:initMessages()
	self.messages = {}
	self.messages["Incorrect State"] = "You can't use jetpack in that state."
	self.messages["Jetpack Enabled"] = "Jetpack has been enabled."
	self.messages["Jetpack Disabled"] = "Jetpack has been disabled."
end

-- Events
function sJetpack:onPlayerChat(args)
	if args.text ~= "/jetpack" then return end
	if args.player:GetState() ~= PlayerState.OnFoot then
		Chat:Send(args.player, self.messages["Incorrect State"], Color.DarkGray)
		return false
	end
	if not args.player:GetValue("JP") then
		args.player:SetNetworkValue("JP", true)
		Chat:Send(args.player, self.messages["Jetpack Enabled"], Color.DodgerBlue)
		return false
	end
	args.player:SetNetworkValue("JP", nil)
	Chat:Send(args.player, self.messages["Jetpack Disabled"], Color.DodgerBlue)
	return false
end

sJetpack = sJetpack()
