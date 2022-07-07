# Temperature Manangement GUI

<p align="center">
  <img src="/readme/gif.gif" alt="Sublime's custom image"/>
</p>

The Raspberry Pi GUI that let's you controll the temperature of a chamber.
<p float="left">
  <img src="https://img.shields.io/badge/Qt-%23217346.svg?style=for-the-badge&logo=Qt&logoColor=white"/>
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white"> 
  <img src="https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white">
</p>



## Key feautures

* The **temperature** values are settable (GUI).
* The **time** periods are settable (GUI).
* The number of **repeats** is settable (GUI).
* The **hysteresis** value is customizable (settings.h).
* **Relay** & **Fan** RPi **pins** are customizable (settings.h).
* Compiles on **arm** as well as **x86** thanks to the use of **preprocessor** & **qmake**.
* Puts controlled **GPIO** pins to **LOW** if program is turned off.
* Displayes **error messages** whenever **python script** or **txt file** is unavailable.
* Checks whether the read **temperature** is valid.
* Hardware uses **PT100** & **custom PCB** to read the temperature via the **SPI protocol**.
* Temperature is **controlled** with the use of a **relay**.
* All of the important data is displayed after the start button has been clicked.
## User Flow Diagram

<p align="center">
  <img src="/readme/userFlow.png" alt="Sublime's custom image"/>
</p>


## Installation

Raspbian installation:

```bash
  comming soon...
```


## License

All code is released under the [MIT](https://choosealicense.com/licenses/mit/) License.

