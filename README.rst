DMX-Colormatch
==============

The purpose of this project is to match the colors of color LED fixtures from different manufacturers and output the corresponding dmx values for further use in light control panels.

Especially for low cost LED fixtures often no photometric data is available, which can be imported into professional lighting control consoles to generate exact colors. With small lighting control consoles this is not possible by design. This leads to the situation that colours have to be adjusted manually with a lot of patience, which is still practicable in the HSV colour space as available on mid- and high-range consoles but is hardly practicable in pure RGB color space or with pure DMX values even for an experienced lighting technician.

Firmaware
---------

Approach
^^^^^^^^

A simple rgbc color sensor is used to record the characteristics of a color setting which is then matched by an algorithm on another fixture by systematically varying DMX values. The system is designed to suppress systematic errors by e.g. differences between sensors (which do not need to be calibrated), the algorithm also eliminates influences from the measurement such as the integration time, which varies depending on the light intesistance.

The algorithm tries to minimize the following equation with n colors of the sensor and one clear value that can be the sum of the readings of all the sensors colors or the reading of a clear sensor:

.. image:: https://latex.codecogs.com/gif.latex?x&space;=&space;\sum_{i=0}^n&space;\left(\frac{cur_i}{cur_c}-\frac{ref_i}{ref_c}\right)^2\quad\text{with}\quad&space;xxx_c=\sum_{i=0}^n&space;xxx_i
   :target: https://latex.codecogs.com/gif.latex?x&space;=&space;\sum_{i=0}^n&space;\left(\frac{cur_i}{cur_c}-\frac{ref_i}{ref_c}\right)^2\quad\text{with}\quad&space;xxx_c=\sum_{i=0}^n&space;xxx_i
..
    x = \sum_{i=0}^n \left(\frac{cur_i}{cur_c}-\frac{ref_i}{ref_c}\right)^2\quad\text{with}\quad xxx_c=\sum_{i=0}^n xxx_i

Using relative values eleminates intesity, which would is a systemtical error when the intesity or measuring distance differs between reference and target fixture. With the given sensor with red(r), green(g), blue(b), clear(c) readings the equation is (writen out):

.. image:: https://latex.codecogs.com/gif.latex?x&space;=&space;\left(\frac{cur_r}{cur_c}-\frac{ref_r}{ref_c}\right)^2&plus;\left(\frac{cur_g}{cur_c}-\frac{ref_g}{ref_c}\right)^2&plus;\left(\frac{cur_b}{cur_c}-\frac{ref_b}{ref_c}\right)^2
    :target: https://latex.codecogs.com/gif.latex?x&space;=&space;\left(\frac{cur_r}{cur_c}-\frac{ref_r}{ref_c}\right)^2&plus;\left(\frac{cur_g}{cur_c}-\frac{ref_g}{ref_c}\right)^2&plus;\left(\frac{cur_b}{cur_c}-\frac{ref_b}{ref_c}\right)^2
..
    x = \left(\frac{cur_r}{cur_c}-\frac{ref_r}{ref_c}\right)^2+\left(\frac{cur_g}{cur_c}-\frac{ref_g}{ref_c}\right)^2+\left(\frac{cur_b}{cur_c}-\frac{ref_b}{ref_c}\right)^2

Algorithm
^^^^^^^^^

By using relatiive values the information about the intesity is lost, which is even wanted. This can be solved by making one channel fixed as absolute value, yielding the problem that we do not know which channel will be the highest one. The most robust aproach is to try to minimized x with each of the channels fixed at usually 255 and to take the result with the smallest x value, which wiill then be the best solution.

The Algorithm itself is then quite simple:

.. image:: misc/algorithm_flowchart/algorithm_flowchart.pdf

At the moment there a two stop conditions. Either wenn the x value is very smal or when at a given iteration count. Also the DMX change step will starts with 5 and will decrease to 1 after 5 iterations. This logic will later be the main factor to minimize the matching time.

Current and Planned Features
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The funtionality will be available via a serial interface and a hardware interface (button and displays).

- [x] parametrize a fixture by sending sensor reading to PC
- [x] take reference colors, which will be matched by ...
- [x] colormatch function (fixture must be conected to dmx output)
- [ ] multiple reference color slots
- [x] programmable start address (usefull at installed fixtures)


Hardware
--------

work in progress

