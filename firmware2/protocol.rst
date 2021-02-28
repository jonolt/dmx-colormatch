
command overview
^^^^^^^^^^^^^^^^
(Deviates slightly from controller command set, must be transfered to controller)

+---------------+-------------+----------------------------------------------------------+
| cmd           | value range | description                                              |
+===============+=============+==========================================================+
| CANCLE        |             | cancle any operation                                     |
+---------------+-------------+----------------------------------------------------------+
| RESET         |             | reset the controller                                     |
+---------------+-------------+----------------------------------------------------------+
| WFS           |             | set wait for serial flag                                 |
+---------------+-------------+----------------------------------------------------------+
| REF           |             | start reference measurement                              |
+---------------+-------------+----------------------------------------------------------+
| MATCH         |             | start matching algorithm                                 |
+---------------+-------------+----------------------------------------------------------+
| PARAM         |             | start reference algorithm (not implemented yet)          |
+---------------+-------------+----------------------------------------------------------+
| DMX?          |             | get current dmx output, ommiting 0 except color channels |
+---------------+-------------+----------------------------------------------------------+
| DMX# XXX@YYY  | 001-255     | set value YYY of dmx address XXX                         |
+---------------+-------------+----------------------------------------------------------+
| DMX*          |             | reset, set all a dmx output to 0 |
+---------------+-------------+----------------------------------------------------------+
| CH?           |             | get current channel values                               |
+---------------+-------------+----------------------------------------------------------+
| CH# XX@YYY    | 001-255     | set value YYY of channel XXX                             |
+---------------+-------------+----------------------------------------------------------+
| COFFSET?      |             | get current channel values                               |
+---------------+-------------+----------------------------------------------------------+
| COFFSET# XX   | 001-255     | set value YYY of channel XXX                             |
+---------------+-------------+----------------------------------------------------------+
| CCH?          |             | get values of all color channels                         |
+---------------+-------------+----------------------------------------------------------+
| CCH XXX [XXX] | 000-255     | set value of all color channels at once                  |
+---------------+-------------+----------------------------------------------------------+
| CHH# X@YYY    |             | set value of given color channel                         |
+---------------+-------------+----------------------------------------------------------+
| CCH*          |             | reset all color ch to 0                                  |
+---------------+-------------+----------------------------------------------------------+
| NCCH?         |             | get number of color channels                             |
+---------------+-------------+----------------------------------------------------------+
| NCCH X        | 1-6         | set number of color channels                             |
+---------------+-------------+----------------------------------------------------------+
| ADD?          |             | get dmx start address                                    |
+---------------+-------------+----------------------------------------------------------+
| ADD XXX       | 001-255     | set dmx start address                                    |
+---------------+-------------+----------------------------------------------------------+
| REG?          |             | get active register                                      |
+---------------+-------------+----------------------------------------------------------+
| REG XX        | 01-16       | set active register                                      |
+---------------+-------------+----------------------------------------------------------+
| RRGBC?        |             | get rgbc values of active register                       |
+---------------+-------------+----------------------------------------------------------+
| RCCH?         |             | get color channel values of active register              |
+---------------+-------------+----------------------------------------------------------+
| RCCH!         |             | set output color channels to register values             |
+---------------+-------------+----------------------------------------------------------+

:WFS:
    After restart the controller will wait for the client to send any data over the serial connection (an existing cnnection cant be dectected on all boards passivly, hence the exploicit way). The WFS-Flag is automaticaly reset.
:REF:
    measures the color of currently in the sensor falling light and saves its values into the active register.
:MATCH:
    runs the matching algorithm for the rgbc-register values and saves the best result in the dmx-register(for the current active register).

(the @ is ignored at the moment as the valies are taken from slices directly)






