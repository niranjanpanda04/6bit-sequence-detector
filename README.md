### 6-Bit Sequence Detector in Verilog
This repository contains the Verilog source code and testbench for a 6-bit sequence detector designed to identify the specific binary pattern 100110 from a serial bitstream. The design was completed as part of a training program dated September 22, 2025. The detector is implemented in two distinct modes: non-overlapping and overlapping.

### Design Specifications
* **Target Sequence**: The detector is configured to identify the 6-bit sequence 100110.
* **Output**: The output Y (or o_f) is asserted to 1 only when the exact sequence is detected. For all other input sequences, the output remains 0.
* **Operating Modes**:
    * **Non-Overlapping**: After a successful detection, the detector resets and does not consider any bits from the matched sequence as part of a new potential match.
    * **Overlapping**: The detector allows for new matches to begin using bits that were part of a previously detected sequence.

### Working Principle
The core of the detector is a Finite State Machine (FSM) that monitors the serial input stream.
* Each state in the FSM represents the number of consecutive bits that have been successfully matched.
* If the incoming bit is correct, the FSM transitions to the next state.
* If a mismatch occurs, the FSM moves to an appropriate state representing a partial match, or it resets.
* The primary difference between the two modes lies in the FSM's behavior after a full match:
    * In non-overlapping mode, the FSM returns to its initial state upon detection.
    * In overlapping mode, it transitions to a state that reuses the final bits of the detected sequence to start searching for the next match.

### Architecture and Pin Description
The design is a single module with one clock input, one serial data input, and one output to indicate a match.

| # | Name | Direction | Width | Function |
| :--- | :--- | :--- | :--- | :--- |
| 1 | i\_clk | Input | 1 | Clock signal input |
| 2 | i\_SI | Input | 1 | Serial data input |
| 3 | o\_f | Output | 1 | Detection flag output |

### File Descriptions
* **vt\_seq\_detect\_100110\_ovl.v**: Source code for the overlapping sequence detector.
* **vt\_seq\_detect\_100110\_novl.v**: Source code for the non-overlapping sequence detector.
* **vt\_sqd\_tb.v**: The main testbench file used to instantiate and verify both the overlapping and non-overlapping modules simultaneously.

### Verification
#### Verification Plan
The verification strategy involved initializing a clock and then providing a specific input pattern to verify the output waveforms for both the overlapping and non-overlapping designs.

#### Functional Verification Waveform
The simulation waveform below demonstrates the behavior of both detectors when subjected to the input stream 100110....
<img width="1560" height="811" alt="Waveform_ovl_novl" src="https://github.com/user-attachments/assets/c9fd8fcf-a1fa-4df2-b44f-4004992aa819" />



### Applications
This type of FSM-based sequence detector is fundamental in various digital systems:
* **Digital Communications**: Used to detect synchronization patterns or control sequences in serial data.
* **Data Monitoring**: Can identify specific markers or headers in network protocols.
* **Error Detection**: Capable of detecting bit patterns that signify errors or special control signals.
* **Educational Purposes**: Serves as a practical example for teaching FSM design concepts in FPGA training.
