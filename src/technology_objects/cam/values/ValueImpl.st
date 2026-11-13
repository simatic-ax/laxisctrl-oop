NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL ValueImpl IMPLEMENTS ICamValue
        VAR PUBLIC
            setValid : BOOL;
            setErrorID : WORD;
            setValue : LREAL;
        END_VAR

        /// Gets the Valid output of the PLCopen instruction. 
        METHOD PUBLIC Valid : BOOL
            Valid := setValid;
        END_METHOD

        /// Gets the Value output of the PLCopen instruction.
        METHOD PUBLIC Value : LREAL
            Value := setValue;
        END_METHOD

        /// Gets the ErrorID output of the PLCopen instruction.
        METHOD PUBLIC ErrorID : WORD
            ErrorID := setErrorID;
        END_METHOD
    END_CLASS

    CLASS INTERNAL CamValueImpl EXTENDS ValueImpl IMPLEMENTS ICamFollowingValue
        VAR PUBLIC
            setFirstDerivative : LREAL;
            setSecondDerivative : LREAL;
            setThirdDerivative : LREAL;
        END_VAR

        /// Gets the value of the first derivative of the following value.
        METHOD PUBLIC FirstDerivative : LREAL
            FirstDerivative := setFirstDerivative;
        END_METHOD

        /// Gets the value of the second derivative of the following value.
        METHOD PUBLIC SecondDerivative : LREAL
            SecondDerivative := setSecondDerivative;
        END_METHOD

        /// Gets the value of the third derivative of the following value.
        METHOD PUBLIC ThirdDerivative : LREAL
            ThirdDerivative := setThirdDerivative;
        END_METHOD
    END_CLASS
END_NAMESPACE
