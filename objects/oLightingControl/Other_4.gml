
switch room {
	case rmLayeredLightingTest:
		add_layer("Assets", false, false)
	break
	case rmJackDarknessTest:
		add_layer("Assets", false, false)
		add_layer("Background", false, true)
	break
	case rmLDTest5:
		add_layer("AssetsBG", false, false)
	break
	default:
		add_layer("Instances", true)
}
