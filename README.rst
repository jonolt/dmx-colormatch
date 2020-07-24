DMX-Colormatch
==============

The purpose of this project is to match the colors of color LED fixtures from different manufacturers and output the corresponding dmx values for further use in light control panels.

Especially for low cost LED fixtures often no photometric data is available, which can be imported into professional lighting control consoles to generate exact colors. With small light control consoles this is not possible by design. Especially for low cost LED fixtures often no photometric data is available, which can be imported into professional lighting control consoles to generate exact colors. With small light control consoles this is not possible by design. This leads to the situation that colours have to be adjusted manually with a lot of patience, which is still possible in the HSV colour space (available on mid-range consoles) but is hardly possible in pure RGB or with pure DMX values even for an experienced lighting technician.

Firmaware
---------

Approach
^^^^^^^^

A simple rgbc color sensor is used to record the characteristics of a color setting which is then matched by an algorithm on another fixture by systematically varying DMX values. The system is designed to suppress systematic errors by e.g. differences between sensors (which do not need to be calibrated), the algorithm also eliminates influences from the measurement such as the integration time, which varies depending on the light intesistance.

The algorithm tries to minimize the following equation with n colors of the sensor and one clear value that can be the sum of the readings of all the sensors colors or the reading of a clear sensor:

.. math::
    x = \sum_{i=0}^n \left(\frac{cur_i}{cur_c}-\frac{ref_i}{ref_c}\right)^2\quad\text{with}\quad xxx_c=\sum_{i=0}^n xxx_i

Using relative values eleminates intesity, which would is a systemtical error when the intesity or measuring distance differs between reference and target fixture. With the given sensor with red(r), green(g), blue(b), clear(c) readings the equation is (writen out):

.. math::
    x = \left(\frac{cur_r}{cur_c}-\frac{ref_r}{ref_c}\right)^2+\left(\frac{cur_g}{cur_c}-\frac{ref_g}{ref_c}\right)^2+\left(\frac{cur_b}{cur_c}-\frac{ref_b}{ref_c}\right)^2

Algorithm
^^^^^^^^^

Since no intesity is left, one dmx channel has to be made a reference channel and has to be constant. The most robust aproach is to make a match with each channel being at a given level (mostly 255) and variying the other. The run with the smallest x value is then the best solution.

The Algorithm itself is then quite simple:
  Flowchart is in work


Hardware
--------

work in progress


