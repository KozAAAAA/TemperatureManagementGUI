# Temperature Manangement GUI

<p align="center">
  <img src="/readme/gif.gif" alt="Sublime's custom image"/>
</p>

<p align="center">
  The Raspberry Pi GUI that lets you control the temperature of a chamber.
</p>


<p align="center">
  <img src="https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white">
  <img src="https://img.shields.io/badge/Qt-%23217346.svg?style=for-the-badge&logo=Qt&logoColor=white"/>
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white"> 
</p>



## Key feautures
* The **temperature** values are settable (GUI).
* The **time** periods are settable (GUI).
* The number of **repeats** is settable (GUI).
* The **hysteresis** value is customizable (settings.h).
* **Relay** & **Fan** RPi **pins** are customizable (settings.h).
* Compiles on **arm** as well as **x86** thanks to the use of **preprocessor** & **qmake**.
* Puts controlled **GPIO** pins to **LOW** if program is turned off.
* Displays **error messages** whenever **python script** or **txt file** is unavailable.
* Checks whether the read **temperature** is valid.
* Hardware uses **PT100** & **custom PCB** to read the temperature via the **SPI protocol**.
* Temperature is **controlled** via the **relay**.
* All of the important data displays if the start button is clicked.
* made with **C++17**, **QML** & **Python**
## User Flow Diagram

<p align="center">
  <img src="/readme/userFlow.png" alt="Sublime's custom image"/>
</p>


## Hardware
The circuit shown below is the Raspberry Pi hat that makes **temperature reading** & **relay control** possible.
<p align=“center”>
  <img src="/readme/render1.png" alt=“Sublime’s custom image”/>
  <img src="/readme/render2.png" alt=“Sublime’s custom image”/>
  <img src="/readme/sch.png" alt=“Sublime’s custom image”/>
</p>

## Installation

Raspbian installation:

```bash
  coming soon...
```


## License

All code is released under the [MIT](https://choosealicense.com/licenses/mit/) License.


