class Config

	# Taille d'une tuile (carrée) dans la fenêtre (en pixel)
	# Choisir un nombre pair, compris entre 16 et 28
	TILE_SIZE = 20
	# Taille de la fenêtre de jeu, qui est carrée (en pixel)
	WINDOW_SIZE = TILE_SIZE ** 2

	# Vitesse initiale du serpent
	START_SPEED = 0.1
	# # Pourcentage d'augmentation de la vitesse du serpent
	# # Ce pourcentage est appliqué à chaque fois qu'il mange un fruit
 	# PERCENT_SPEED_INCREASE = 3
end
