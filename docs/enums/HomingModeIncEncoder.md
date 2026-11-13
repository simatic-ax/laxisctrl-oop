# HomingModeIncEncoder

| Symbol | Value | Description |
| ------ | ----- | ----------- |
| PASSIVE_WITHOUT_RESET | INT#2 | When the homing mark is detected, the actual value is set to the value of the Position parameter (status homed remains active) |
| ACTIVE_WITH_POSITION_PARAMETER | INT#3 | The positioning axis/synchronous axis technology object performs a homing movement according to the configuration |
| ACTIVE | INT#5 | The positioning axis/synchronous axis technology object performs a homing movement according to the configuration |
| PASSIVE_WITH_POSITION_PARAMETER | INT#8 | When the homing mark is detected, the actual value is set to the value of the Position parameter |
| PASSIVE | INT#10 | When the homing mark is detected, the actual value is set to the home position configured in the properties of the axis technology object |
| ADJUSTMENT_SENSOR | INT#13 | The current position is set to the value of parameter Position |
| ACTIVE_ON_FIXED_STOP | INT#20 | Homes the axis via fixed stop detection |
| ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING | INT#21 | Homes the axis via fixed stop detection and moves out of clamping |
| ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION | INT#22 | Homes the axis via fixed stop detection and moves to a target position |
