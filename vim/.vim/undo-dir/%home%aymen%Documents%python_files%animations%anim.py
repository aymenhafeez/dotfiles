Vim�UnDo� �Z���WP�x��ڮR�:�V�������O�   I                                   ^3=�    _�                             ����                                                                                                                                                                                                                                                                                                                                                  V        ^3�     �                    """   "    Produces an animated 2-D plot.           Parameters       ==========   "    fig        : matplotlib figure   &    lines      : empty matplotlib plot   %    x, y       : points being plotted   O    trail      : if True, all points up to the ith point are plotted each frame   C                 if False, only the ith point is plotted each frame       plot_speed : int   .    **kwargs   : other arguments passable into   5                 matplotlib.animation.FuncAnimation()       """5�_�                             ����                                                                                                                                                                                                                                                                                                                                       2          V       ^3�    �                     """   "    Produces an animated 3-D plot.           Parameters       ==========   &    fig            : matplotlib figure   $    ax             : matplotlib axes   >    lines          : empty matplotlib plot contained in a list   I    points         : empty matplotlib plot contained in a list; shows the   ,                     ith point being plotted   /    x, y, z        : list; points being plotted       plot_speed     : int    4    rotation_speed : int; proportional to plot_speed   <                     ---> keep blit=False (default) for this   C    l_num          : number of points plotted to 'lines' each frame   D    p_num          : number of points plotted to 'points' each frame   2    **kwargs       : other arguments passable into   9                     matplotlib.animation.FuncAnimation()       """5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V       ^3�     �      !   C    5�_�                            ����                                                                                                                                                                                                                                                                                                                            !          !          V       ^3�    �         D    5�_�                   @        ����                                                                                                                                                                                                                                                                                                                            @          A          V       ^3�     �   @   B                      fig.canvas.draw()�   ?   A          0            ax.view_init(30, rotation_speed * i)5�_�                    #       ����                                                                                                                                                                                                                                                                                                                            @          A          V       ^3�    �   "   $   E      A                 rotation_speed=0.0, l_num=0, p_num=1, **kwargs):5�_�         	          E   "    ����                                                                                                                                                                                                                                                                                                                            @          A          V       ^3(     �   D              +                                  **kwargs)5�_�                    E        ����                                                                                                                                                                                                                                                                                                                            @          A          V       ^3+    �   C              M        self.anim = FuncAnimation(fig, _animate, init_func=_init, interval=1,   *kwargs)�   D              *                                  *kwargs)5�_�                    D   M    ����                                                                                                                                                                                                                                                                                                                            @          A          V       ^3.     �   C              V        self.anim = FuncAnimation(fig, _animate, init_func=_init, interval=1, *kwargs)5�_�                    D   M    ����                                                                                                                                                                                                                                                                                                                            @          A          V       ^35   
 �   C              V        self.anim = FuncAnimation(fig, _animate, init_func=_init, interval=1, *kwargs)5�_�                            ����                                                                                                                                                                                                                                                                                                                                       D          V       ^3)�     �                   �               �              D   .from matplotlib.animation import FuncAnimation   import numpy as np           class AnimPlot:       N    def __init__(self, fig, lines, x, y, trail=True, plot_speed=10, **kwargs):               def _init():   "            lines.set_data([], [])               return lines,               if len(x) != len(y):   >            raise ValueError('x and y must be the same size.')               def _animate(i):   B            lines.set_data(x[:plot_speed * i], y[:plot_speed * i])               return lines,       %        def _animate_single_point(i):   @            lines.set_data(x[plot_speed * i], y[plot_speed * i])               return lines,               if trail == True:   E            animation = FuncAnimation(fig, _animate, init_func=_init,   F                                      interval=1, blit=True, **kwargs)           else:   A            animation = FuncAnimation(fig, _animate_single_point,   K                                      init_func=_init, blit=True, **kwargs)           class AnimPlot3D:       F    def __init__(self, fig, ax, lines, points, x, y, z, plot_speed=10,   -                 l_num=0, p_num=1, **kwargs):               def _init():   <            for self.line, self.point in zip(lines, points):   *                self.line.set_data([], [])   /                self.line.set_3d_properties([])       +                self.point.set_data([], [])   0                self.point.set_3d_properties([])   !            return lines + points                def shape_data(x, y, z):   &            data = np.array([x, y, z])   /            data_transpose = np.array([data]).T   M            data_plot = np.reshape(data_transpose, (1, len(x), 3), order='C')               return data_plot               def _animate(i):   '            array = shape_data(x, y, z)   1            i = (plot_speed * i) % array.shape[1]       N            for self.line, self.point, self.data in zip(lines, points, array):   8                self.x, self.y, self.z = self.data[:i].T   D                self.line.set_data(self.x[-l_num:], self.y[-l_num:])   <                self.line.set_3d_properties(self.z[-l_num:])       E                self.point.set_data(self.x[-p_num:], self.y[-p_num:])   =                self.point.set_3d_properties(self.z[-p_num:])       2            # ax.view_init(30, rotation_speed * i)               # fig.canvas.draw()   !            return lines + points       a        self.anim = FuncAnimation(fig, _animate, init_func=_init, interval=1, blit=True, *kwargs)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        ^3)�     �                    """   "    Produces an animated 2-D plot.           Parameters       ==========   "    fig        : matplotlib figure   &    lines      : empty matplotlib plot   +    x, y       : list; points being plotted   O    trail      : if True, all points up to the ith point are plotted each frame   C                 if False, only the ith point is plotted each frame       plot_speed : int   .    **kwargs   : other arguments passable into   5                 matplotlib.animation.FuncAnimation()       """5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        ^3)�     �         Z    5�_�                    !        ����                                                                                                                                                                                                                                                                                                                            !          3          V       ^3)�     �       !              """   "    Produces an animated 3-D plot.           Parameters       ==========   &    fig            : matplotlib figure   $    ax             : matplotlib axes   >    lines          : empty matplotlib plot contained in a list   I    points         : empty matplotlib plot contained in a list; shows the   ,                     ith point being plotted   /    x, y, z        : list; points being plotted       plot_speed     : int    4    rotation_speed : int; proportional to plot_speed   <                     ---> keep blit=False (default) for this   C    l_num          : number of points plotted to 'lines' each frame   D    p_num          : number of points plotted to 'points' each frame   2    **kwargs       : other arguments passable into   9                     matplotlib.animation.FuncAnimation()       """5�_�                    !       ����                                                                                                                                                                                                                                                                                                                                                             ^3)�    �       "   H    5�_�                            ����                                                                                                                                                                                                                                                                                                                            "          "          V       ^3=�     �                 .from matplotlib.animation import FuncAnimation5�_�                             ����                                                                                                                                                                                                                                                                                                                            !          !          V       ^3=�    �         H    �         H    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        ^3)�     �              �         [       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        ^3)�     �         h         "             "   &   +   O   C      .   5   5�_�               	   "        ����                                                                                                                                                                                                                                                                                                                            D          D          V       ^3�    �   !   #   E      B    def __init__(self, fig, lines, points, x, y, z, plot_speed=10,5�_�   	       
          E   $    ����                                                                                                                                                                                                                                                                                                                            D          D          V       ^3     �   E   F           5�_�   	              
   ,       ����                                                                                                                                                                                                                                                                                                                            @          A          V       ^3�    �   +   -   E                   return lines, points5�_�              	      E   "    ����                                                                                                                                                                                                                                                                                                                            @          A          V       ^3�     �   D   F          "                                  5�_�                    @        ����                                                                                                                                                                                                                                                                                                                            @          @          V       ^3�     �   ?   B        5��