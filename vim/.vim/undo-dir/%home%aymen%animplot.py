Vim�UnDo� ���+�_Vu��lٖ��l��$r״�89��.��   @   @            animation = FuncAnimation(fig, _animat_single_point,      2      <       <   <   <    ^��   $ _�                             ����                                                                                                                                                                                                                                                                                                                                                             ^��     �                   �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ^��     �          %    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ^��     �          &    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ^��     �          '       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^��    �          (       �          '    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^��    �          (      'import matplotlib.anmation as animation5�_�                            ����                                                                                                                                                                                                                                                                                                                                       (          V       ^�H     �               �               �             $   class AnimPlot3D:   F    def __init__(self, fig, ax, lines, points, x, y, z, plot_speed=10,   A                 rotation_speed=0.0, l_num=0, p_num=1, **kwargs):               def _init():   <            for self.line, self.point in zip(lines, points):   *                self.line.set_data([], [])   /                self.line.set_3d_properties([])       +                self.point.set_data([], [])   0                self.point.set_3d_properties([])   !            return lines + points                def shape_data(x, y, z):   &            data = np.array([x, y, z])   /            data_transpose = np.array([data]).T   M            data_plot = np.reshape(data_transpose, (1, len(x), 3), order='C')               return data_plot               def _animate(i):   '            array = shape_data(x, y, z)   1            i = (plot_speed * i) % array.shape[1]       N            for self.line, self.point, self.data in zip(lines, points, array):   8                self.x, self.y, self.z = self.data[:i].T   D                self.line.set_data(self.x[-l_num:], self.y[-l_num:])   <                self.line.set_3d_properties(self.z[-l_num:])       E                self.point.set_data(self.x[-p_num:], self.y[-p_num:])   =                self.point.set_3d_properties(self.z[-p_num:])       0            ax.view_init(30, rotation_speed * i)               fig.canvas.draw()   !            return lines + points       a        self.anim = animation.FuncAnimation(fig, _animate, init_func=_init, interval=1, **kwargs)5�_�      	                      ����                                                                                                                                                                                                                                                                                                                                                  V        ^�L    �                    """   "    Produces an animated 3-D plot.           Parameters       ==========   &    fig            : matplotlib figure   $    ax             : matplotlib axes   >    lines          : empty matplotlib plot contained in a list   I    points         : empty matplotlib plot contained in a list; shows the   ,                     ith point being plotted   /    x, y, z        : list; points being plotted       plot_speed     : int    4    rotation_speed : int; proportional to plot_speed   <                     ---> keep blit=False (default) for this   C    l_num          : number of points plotted to 'lines' each frame   D    p_num          : number of points plotted to 'points' each frame   2    **kwargs       : other arguments passable into   9                     matplotlib.animation.FuncAnimation()       """5�_�      
           	           ����                                                                                                                                                                                                                                                                                                                                                  V        ^�^   	 �          )      (import matplotlib.animation as animation5�_�   	              
           ����                                                                                                                                                                                                                                                                                                                                                             ^�?     �         *       �         )    5�_�   
                 
       ����                                                                                                                                                                                                                                                                                                                                                             ^��     �   	      1              return lines5�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             ^��   
 �      
   1      !            line.set_data([], [])5�_�                    
       ����                                                                                                                                                                                                                                                                                                                                                             ^��     �   
      2          �   
      1    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^��     �         3              def animate5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^��     �         3              def animate5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^��     �         3              def _animate5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^��     �         3          def _animate(i):5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^��     �         3              def _animate(i):5�_�                       )    ����                                                                                                                                                                                                                                                                                                                                                             ^��    �         4      3    def __inot__(self, fig, lines, x, y, **kwargs):5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^�    �         4                  lines.set_data(x[:5�_�                       '    ����                                                                                                                                                                                                                                                                                                                                                             ^�    �         5                  �         4    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^��     �         5              return lines,5�_�                    
       ����                                                                                                                                                                                                                                                                                                                                                             ^��    �   	      5              return lines,5�_�                       %    ����                                                                                                                                                                                                                                                                                                                                                             ^�    �         5      (            lines.set_data(x[:i],  y[i])5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ^�     �         6       �         5    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^�    �                        5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^�"    �         6              �         5    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             ^�    �         7      G        anim = FuncAnimation(fig, _animate, init_fun=_init, interval=1)5�_�                       9    ����                                                                                                                                                                                                                                                                                                                                                             ^�    �         7      L        animation = FuncAnimation(fig, _animate, init_fun=_init, interval=1)5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ^�%    �         7      ?    def __inot__(self, fig, lines, x, y, trail=True, **kwargs):5�_�      !                     ����                                                                                                                                                                                                                                                                                                                                                             ^?�     �         8              �         7    5�_�       "           !      %    ����                                                                                                                                                                                                                                                                                                                                                             ^?�    �         ;                  �         :    5�_�   !   #           "      
    ����                                                                                                                                                                                                                                                                                                                                                             ^?�     �         ;    5�_�   "   $           #           ����                                                                                                                                                                                                                                                                                                                                                             ^?�     �         <       5�_�   #   %           $           ����                                                                                                                                                                                                                                                                                                                                                V       ^?�     �         <      M        animation = FuncAnimation(fig, _animate, init_func=_init, interval=1)5�_�   $   &           %          ����                                                                                                                                                                                                                                                                                                                                                V       ^?�    �         =                  �         <    5�_�   %   '           &      P    ����                                                                                                                                                                                                                                                                                                                                                V       ^@
     �         >      Q            animation = FuncAnimation(fig, _animate, init_func=_init, interval=1)5�_�   &   )           '      \    ����                                                                                                                                                                                                                                                                                                                                                V       ^@    �         >      ]            animation = FuncAnimation(fig, _animat_single_point, init_func=_init, interval=1)5�_�   '   *   (       )           ����                                                                                                                                                                                                                                                                                                                                                V       ^@�     �         >    5�_�   )   +           *           ����                                                                                                                                                                                                                                                                                                                                                V       ^@�     �         ?       5�_�   *   ,           +          ����                                                                                                                                                                                                                                                                                                                                                V       ^@�     �         @       �         ?    5�_�   +   -           ,          ����                                                                                                                                                                                                                                                                                                                                                V       ^@�     �         @      .5�_�   ,   .           -          ����                                                                                                                                                                                                                                                                                                                                                V       ^@�     �         A       �         @    5�_�   -   /           .          ����                                                                                                                                                                                                                                                                                                                                                V       ^@�     �         B       �         A    5�_�   .   0           /          ����                                                                                                                                                                                                                                                                                                                                                V       ^A     �                .    . .   . . .   . . . .5�_�   /   1           0           ����                                                                                                                                                                                                                                                                                                                                                V       ^A     �         ?       �         >    5�_�   0   2           1           ����                                                                                                                                                                                                                                                                                                                                                V       ^A
     �         @      .    �         @       �         ?    5�_�   1   3           2          ����                                                                                                                                                                                                                                                                                                                                                V       ^A     �         ?      .5�_�   2   4           3          ����                                                                                                                                                                                                                                                                                                                                                V       ^A     �         ?      . .5�_�   3   5           4           ����                                                                                                                                                                                                                                                                                                                                                V       ^A    �                . . .5�_�   4   6           5           ����                                                                                                                                                                                                                                                                                                                                                  V        ^j�     �         >      g            animation = FuncAnimation(fig, _animat_single_point, init_func=_init, interval=1, **kwargs)5�_�   5   7           6          ����                                                                                                                                                                                                                                                                                                                                                  V        ^j�     �         ?      :                    init_func=_init, interval=1, **kwargs)5�_�   6   8           7      Z    ����                                                                                                                                                                                                                                                                                                                               %          Z       v   Z    ^k      �         ?      [            animation = FuncAnimation(fig, _animate, init_func=_init, interval=1, **kwargs)5�_�   7   9           8          ����                                                                                                                                                                                                                                                                                                                                                             ^k    �         @      )                    interval=1, **kwargs)5�_�   8   :           9          ����                                                                                                                                                                                                                                                                                                                                                             ^��     �         @    5�_�   9   ;           :           ����                                                                                                                                                                                                                                                                                                                               %                  v   Z    ^�     �                 5�_�   :   <           ;          ����                                                                                                                                                                                                                                                                                                                                                             ^��     �         @      $        def _animat_single_point(i):5�_�   ;               <      2    ����                                                                                                                                                                                                                                                                                                                                                             ^��   $ �         @      @            animation = FuncAnimation(fig, _animat_single_point,5�_�   '           )   (           ����                                                                                                                                                                                                                                                                                                                                                  V        ^@Z     �      
   >      +        def _init(): lines.set_data([], [])5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             ^��    �         7      class AnimPlot5��