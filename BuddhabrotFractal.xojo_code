#tag Class
Protected Class BuddhabrotFractal
	#tag Method, Flags = &h0
		Function DrawBuddhabrotFractal(width As Integer, height As Integer, maxIterations As Integer, samples As Integer) As Picture
		  // Initialisation du tableau de compteurs
		  Dim counts(3840, 2160) As Integer
		  
		  // Génération des échantillons
		  For sample As Integer = 1 To samples
		    // Initialisation des variables pour la suite de Julia
		    Dim x As Double = 0
		    Dim y As Double = 0
		    Dim xtemp As Double
		    Dim ytemp As Double
		    Dim iteration As Integer = 0
		    
		    // Calcul d'un point aléatoire dans l'ensemble de Mandelbrot
		    Dim cx As Double = Rnd() * 3.5 - 2.5
		    Dim cy As Double = Rnd() * 3.5 - 2.5
		    
		    While (x * x + y * y < 4) And (iteration < maxIterations)
		      xtemp = x * x - y * y + cx
		      ytemp = 2 * x * y + cy
		      x = xtemp
		      y = ytemp
		      
		      // Si le point est dans l'ensemble de Mandelbrot, incrémenter le compteur correspondant
		      If x >= -2 And x <= 2 And y >= -2 And y <= 2 Then
		        Dim px As Integer = width * (x + 2) / 4
		        Dim py As Integer = height * (y + 2) / 4
		        counts(px, py) = counts(px, py) + 1
		      End If
		      
		      iteration = iteration + 1
		    Wend
		  Next
		  
		  // Création d'un objet Picture pour dessiner la fractale Buddhabrot
		  Dim fractalPic As New Picture(width, height, 32)
		  Dim g As Graphics = fractalPic.Graphics
		  
		  // Recherche du nombre maximal d'itérations pour normaliser les couleurs
		  Dim maxCount As Integer = 0
		  For y As Integer = 0 To height - 1
		    For x As Integer = 0 To width - 1
		      If counts(x, y) > maxCount Then
		        maxCount = counts(x, y)
		      End If
		    Next
		  Next
		  
		  // Parcours de chaque pixel de l'objet Picture
		  For y As Integer = 0 To height - 1
		    For x As Integer = 0 To width - 1
		      // Normalisation de la couleur en fonction du nombre de fois où le pixel a été visité
		      Dim colorValue As Double = counts(x, y) / maxCount
		      Dim xcolor As Color = Color.RGB(255 * colorValue, 255 * colorValue, 255 * colorValue)
		      
		      // Dessin du pixel dans l'objet Graphics
		      g.DrawingColor = xcolor
		      g.DrawLine(x,y,x,y)
		    Next
		  Next
		  
		  // Retour de l'objet Picture contenant la fractale Buddhabrot
		  Return fractalPic
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
