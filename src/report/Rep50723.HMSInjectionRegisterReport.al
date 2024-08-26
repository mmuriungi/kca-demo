report 50723 "HMS Injection Register Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSInjectionRegisterReport.rdl';

    dataset
    {
        dataitem(DataItem3772; "HMS-Treatment Form Injection")
        {
            column(Injection_18_; Injection[18])
            {
            }
            column(Injection_15_; Injection[15])
            {
            }
            column(Injection_16_; Injection[16])
            {
            }
            column(Injection_17_; Injection[17])
            {
            }
            column(Injection_14_; Injection[14])
            {
            }
            column(Injection_13_; Injection[13])
            {
            }
            column(Injection_12_; Injection[12])
            {
            }
            column(Injection_11_; Injection[11])
            {
            }
            column(Injection_10_; Injection[10])
            {
            }
            column(Injection_9_; Injection[9])
            {
            }
            column(Injection_8_; Injection[8])
            {
            }
            column(Injection_7_; Injection[7])
            {
            }
            column(Injection_6_; Injection[6])
            {
            }
            column(Injection_5_; Injection[5])
            {
            }
            column(Injection_4_; Injection[4])
            {
            }
            column(Injection_3_; Injection[3])
            {
            }
            column(Injection_2_; Injection[2])
            {
            }
            column(Injection_1_; Injection[1])
            {
            }
            column(UPPERCASE_COMPANYNAME_; UPPERCASE(COMPANYNAME))
            {
            }
            column(Drug_1_; Drug[1])
            {
            }
            column(PFNo_1_; PFNo[1])
            {
            }
            column(PatientName_1_; PatientName[1])
            {
            }
            column(Dose_1_; Dose[1])
            {
            }
            column(PFNo_2_; PFNo[2])
            {
            }
            column(PatientName_2_; PatientName[2])
            {
            }
            column(Drug_2_; Drug[2])
            {
            }
            column(Dose_2_; Dose[2])
            {
            }
            column(SIGNATURECaption; SIGNATURECaptionLbl)
            {
            }
            column(DOSECaption; DOSECaptionLbl)
            {
            }
            column(DRUGCaption; DRUGCaptionLbl)
            {
            }
            column(NAMECaption; NAMECaptionLbl)
            {
            }
            column(OP_IP_NO_Caption; OP_IP_NO_CaptionLbl)
            {
            }
            column(SIGNATURECaption_Control1102760076; SIGNATURECaption_Control1102760076Lbl)
            {
            }
            column(DOSECaption_Control1102760093; DOSECaption_Control1102760093Lbl)
            {
            }
            column(DRUGCaption_Control1102760100; DRUGCaption_Control1102760100Lbl)
            {
            }
            column(NAMECaption_Control1102760112; NAMECaption_Control1102760112Lbl)
            {
            }
            column(DATE__________________________________________________Caption; DATE__________________________________________________CaptionLbl)
            {
            }
            column(OP_IP_NO_Caption_Control1102760119; OP_IP_NO_Caption_Control1102760119Lbl)
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(INJECTION_REGISTERCaption; INJECTION_REGISTERCaptionLbl)
            {
            }
            column(HMS_Treatment_Form_Injection_Treatment_No_; "Treatment No.")
            {
            }
            column(HMS_Treatment_Form_Injection_Injection_No_; "Injection No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF FirstRecordPrinted THEN BEGIN NEXT(-1) END;
                FOR IntD := 1 TO 2 DO BEGIN
                    Treatment.RESET;
                    Treatment.GET("Treatment No.");
                    Patient.RESET;
                    Patient.GET(Treatment."Patient No.");
                    PatientName[IntD] := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    IF Patient."Patient Type" = Patient."Patient Type"::Others THEN BEGIN
                        PFNo[IntD] := Patient."Student No.";
                    END
                    ELSE
                        IF Patient."Patient Type" = Patient."Patient Type"::" " THEN BEGIN
                            PFNo[IntD] := Patient."Patient No.";
                        END
                        ELSE BEGIN
                            PFNo[IntD] := Patient."Employee No.";
                        END;
                    Drug[IntD] := "Injection No.";
                    Dose[IntD] := FORMAT("Injection Quantity") + ' ' + "Injection Unit of Measure";
                    NEXT();
                END;
                FirstRecordPrinted := TRUE;
            end;

            trigger OnPreDataItem()
            begin
                //LastFieldNo := FIELDNO(Code);
                IntC := 1;
                InjectionRec.RESET;
                IF InjectionRec.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        Injection[IntC] := InjectionRec.Description;
                        IntC := IntC + 1;
                        NEXT(1);
                    END;
                    UNTIL InjectionRec.NEXT = 0;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IntD := 1;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Injection: array[18] of Text[100];
        IntC: Integer;
        InjectionRec: Record "HMS-Setup Injection";
        IntD: Integer;
        TreatmentInjection: Record "HMS-Treatment Form Injection";
        PFNo: array[2] of Code[20];
        PatientName: array[2] of Text[200];
        Drug: array[2] of Code[10];
        Dose: array[2] of Code[30];
        Patient: Record "HMS-Patient";
        Treatment: Record "HMS-Treatment Form Header";
        FirstRecordPrinted: Boolean;
        SIGNATURECaptionLbl: Label 'SIGNATURE';
        DOSECaptionLbl: Label 'DOSE';
        DRUGCaptionLbl: Label 'DRUG';
        NAMECaptionLbl: Label 'NAME';
        OP_IP_NO_CaptionLbl: Label 'OP/IP NO.';
        SIGNATURECaption_Control1102760076Lbl: Label 'SIGNATURE';
        DOSECaption_Control1102760093Lbl: Label 'DOSE';
        DRUGCaption_Control1102760100Lbl: Label 'DRUG';
        NAMECaption_Control1102760112Lbl: Label 'NAME';
        DATE__________________________________________________CaptionLbl: Label 'DATE _________________________________________________';
        OP_IP_NO_Caption_Control1102760119Lbl: Label 'OP/IP NO.';
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        INJECTION_REGISTERCaptionLbl: Label 'INJECTION REGISTER';
}

