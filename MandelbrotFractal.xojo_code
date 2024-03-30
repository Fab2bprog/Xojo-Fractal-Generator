#tag Class
Protected Class MandelbrotFractal
	#tag Method, Flags = &h0
		Function DrawMandelbrotFractal(width As Integer, height As Integer, maxIterations As Integer, zoomFactor As Double, offsetX As Double, offsetY As Double) As Picture
		  // Création d'un objet Picture pour dessiner la fractale de Mandelbrot
		  Dim fractalPic As New Picture(width, height, 32)
		  Dim g As Graphics = fractalPic.Graphics
		  
		  // Parcours de chaque pixel de l'objet Picture
		  For y As Integer = 0 To height - 1
		    For x As Integer = 0 To width - 1
		      // Conversion des coordonnées de l'écran aux coordonnées de la fractale de Mandelbrot
		      Dim zx As Double = 1.5 * (x - width / 2) / (0.5 * zoomFactor * width) + offsetX
		      Dim zy As Double = (y - height / 2) / (0.5 * zoomFactor * height) + offsetY
		      
		      Dim cx As Double = zx
		      Dim cy As Double = zy
		      
		      Dim iteration As Integer = 0
		      Dim xtemp As Double
		      While (zx * zx + zy * zy <= 4.0) And (iteration < maxIterations)
		        xtemp = zx * zx - zy * zy + cx
		        zy = 2.0 * zx * zy + cy
		        zx = xtemp
		        iteration = iteration + 1
		      Wend
		      
		      // Couleur en fonction du nombre d'itérations
		      Dim xcolor As Color
		      If iteration = maxIterations Then
		        // Pour les points à l'intérieur de l'ensemble de Mandelbrot
		        Dim smoothColor As Double = iteration + 1 - Log(Log(Sqrt(zx * zx + zy * zy))) / Log(2.0)
		        Dim smoothColorRatio As Double = smoothColor / maxIterations
		        Dim hue As Double = 0.7 + 10 * smoothColorRatio
		        xcolor = Color.HSV(hue, 1.0, 1.0)
		      Else
		        // Pour les points en dehors de l'ensemble de Mandelbrot
		        Dim smoothColor As Double = iteration + 1 - Log(Log(Sqrt(zx * zx + zy * zy))) / Log(2.0)
		        Dim smoothColorRatio As Double = smoothColor / maxIterations
		        Dim shade As Integer = 255 * smoothColorRatio
		        xcolor = Color.RGB(shade, shade, shade)
		      End If
		      
		      // Dessin du pixel dans l'objet Graphics
		      g.DrawingColor = xcolor
		      g.DrawLine(x,y,x,y)
		    Next
		  Next
		  
		  // Retour de l'objet Picture contenant la fractale de Mandelbrot
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
