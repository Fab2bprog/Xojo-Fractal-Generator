#tag Class
Protected Class NewtonFractal
	#tag Method, Flags = &h0
		Function DrawNewtonFractal(width As Integer, height As Integer, maxIterations As Integer) As Picture
		  // Initialisation du tableau de comptage des itérations
		  Dim counts(3840, 2860) As Integer
		  
		  // Parcours de chaque pixel de l'objet Picture
		  For py As Integer = 0 To height - 1
		    For px As Integer = 0 To width - 1
		      // Conversion des coordonnées de l'écran aux coordonnées complexes
		      Dim re As Double = Map(px, 0, width - 1, -2, 2)
		      Dim im As Double = Map(py, 0, height - 1, -2, 2)
		      Dim x As Double = re
		      Dim y As Double = im
		      
		      // Méthode de Newton pour trouver une racine
		      Dim iteration As Integer = 0
		      Dim dx As Double
		      Dim dy As Double
		      Do
		        Dim xSquared As Double = x * x
		        Dim ySquared As Double = y * y
		        Dim xCubed As Double = xSquared * x
		        Dim yCubed As Double = ySquared * y
		        
		        Dim numeratorRe As Double = xCubed - 3 * x * ySquared - 2 * x + 2
		        Dim numeratorIm As Double = 3 * xSquared * y - yCubed
		        Dim denominator As Double = 3 * xSquared - 3 * ySquared
		        
		        dx = numeratorRe / denominator
		        dy = numeratorIm / denominator
		        
		        x = x - dx
		        y = y - dy
		        
		        iteration = iteration + 1
		      Loop Until (Abs(dx) < 0.000001) And (Abs(dy) < 0.000001) Or (iteration >= maxIterations)
		      
		      // Attribution de la couleur en fonction du nombre d'itérations
		      Dim xcolor As Color
		      If iteration = maxIterations Then
		        xcolor = Color.RGB(255, 255, 255) // Blanc
		      Else
		        // Utilisation d'un dégradé de bleu, de gris et de vert en fonction du nombre d'itérations
		        Dim blue As Double = iteration / maxIterations * 255
		        Dim gray As Double = 128 + iteration / maxIterations * 127
		        Dim green As Double = (maxIterations - iteration) / maxIterations * 255
		        xcolor = Color.RGB(blue, gray, green)
		      End If
		      
		      // Dessin du pixel dans l'objet Picture
		      counts(px, py) = iteration
		    Next
		  Next
		  
		  // Création d'un objet Picture pour dessiner la fractale de Newton
		  Dim fractalPic As New Picture(width, height, 32)
		  Dim g As Graphics = fractalPic.Graphics
		  
		  // Recherche du nombre maximal d'itérations pour normaliser les couleurs
		  Dim maxCount As Integer = 0
		  For py As Integer = 0 To height - 1
		    For px As Integer = 0 To width - 1
		      If counts(px, py) > maxCount Then
		        maxCount = counts(px, py)
		      End If
		    Next
		  Next
		  
		  // Parcours de chaque pixel de l'objet Picture
		  For py As Integer = 0 To height - 1
		    For px As Integer = 0 To width - 1
		      // Normalisation de la couleur en fonction du nombre d'itérations
		      Dim colorValue As Double = counts(px, py) / maxCount
		      Dim xcolor As Color = Color.RGB(255 * colorValue, 255 * colorValue, 255 * colorValue)
		      
		      // Dessin du pixel dans l'objet Graphics
		      g.DrawingColor = xcolor
		      g.DrawLine(px,py,px,py)
		    Next
		  Next
		  
		  // Retour de l'objet Picture contenant la fractale de Newton
		  Return fractalPic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Map(value As Double, fromLow As Double, fromHigh As Double, toLow As Double, toHigh As Double) As Double
		  Return toLow + (value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow)
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
