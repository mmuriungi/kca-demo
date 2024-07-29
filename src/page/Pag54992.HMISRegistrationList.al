page 54992 "HMIS-Registration List"
{
    CardPageID = "HMIS-Registration Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMIS-Visits/Registrations";
    SourceTableView = WHERE(Status = FILTER(Registration));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch Date"; Rec."Batch Date")
                {
                    ApplicationArea = All;
                }
                field("Visit Number"; Rec."Visit Number")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                }
                field("In-patient No."; Rec."In-patient No.")
                {
                    ApplicationArea = All;
                }
                field("Out-Patient No."; Rec."Out-Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Registration Time"; Rec."Registration Time")
                {
                    ApplicationArea = All;
                }
                field(Discharged; Rec.Discharged)
                {
                    ApplicationArea = All;
                }
                field("Discharge Date/Time"; Rec."Discharge Date/Time")
                {
                    ApplicationArea = All;
                }
                field("Discharged by"; Rec."Discharged by")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Insurance Card No."; Rec."Insurance Card No.")
                {
                    ApplicationArea = All;
                }
                field("Insurance Firm Code"; Rec."Insurance Firm Code")
                {
                    ApplicationArea = All;
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ApplicationArea = All;
                }
                field("Insurance Cap (Outpatient)"; Rec."Insurance Cap (Outpatient)")
                {
                    ApplicationArea = All;
                }
                field("Insurance Cap (inpatient)"; Rec."Insurance Cap (inpatient)")
                {
                    ApplicationArea = All;
                }
                field("Insurance Verified"; Rec."Insurance Verified")
                {
                    ApplicationArea = All;
                }
                field("Insurance Veriyfied by"; Rec."Insurance Veriyfied by")
                {
                    ApplicationArea = All;
                }
                field("Insurance Verified Date"; Rec."Insurance Verified Date")
                {
                    ApplicationArea = All;
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = All;
                }
                field("Temperature (Celcious)"; Rec."Temperature (Celcious)")
                {
                    ApplicationArea = All;
                }
                field("Height (CM)"; Rec."Height (CM)")
                {
                    ApplicationArea = All;
                }
                field("Weight (KGs)"; Rec."Weight (KGs)")
                {
                    ApplicationArea = All;
                }
                field(BMI; Rec.BMI)
                {
                    ApplicationArea = All;
                }
                field("Previous Temperature (Cel.)"; Rec."Previous Temperature (Cel.)")
                {
                    ApplicationArea = All;
                }
                field("Previous Height (CM)"; Rec."Previous Height (CM)")
                {
                    ApplicationArea = All;
                }
                field("Previous Weight (KGs)"; Rec."Previous Weight (KGs)")
                {
                    ApplicationArea = All;
                }
                field("Previous BMI"; Rec."Previous BMI")
                {
                    ApplicationArea = All;
                }
                field("Triage By"; Rec."Triage By")
                {
                    ApplicationArea = All;
                }
                field("Test Date/Time"; Rec."Test Date/Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(SendToTriage)
            {
                Caption = 'Send to Triage';
                Image = Register;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    HMISClinicianAllocationBuff: Record "HMIS-Clinician Allocation Buff";
                    HMISCliniciansRegister: Record "HMIS-Clinicians Register";
                begin
                    IF CONFIRM('Send to Triage?', TRUE) = FALSE THEN ERROR('Cancelled!');
                    HMISNoSeries.RESET;
                    IF HMISNoSeries.FIND('-') THEN BEGIN
                        HMISNoSeries.TESTFIELD("Triage Nos.");
                        HMISNoSeries.TESTFIELD("Patient Nos.");
                        HMISNoSeries.TESTFIELD("Visit Nos.");
                        HMISNoSeries.TESTFIELD("Finance Trans. Nos.");
                        Rec."Triage No." := NoSeriesManagement.GetNextNo(HMISNoSeries."Triage Nos.", TODAY, TRUE);
                        //Update Current Status
                        Rec.Status := Rec.Status::Triage;
                        Rec."Current Location" := 'TRIAGE';
                        Rec.MODIFY;
                        //Create a Triage Entry here
                        HMISVitals.INIT;
                        HMISVitals."Batch Date" := Rec."Batch Date";
                        HMISVitals."Visit Number" := Rec."Visit Number";
                        HMISVitals."Patient No." := Rec."Patient No.";
                        HMISVitals.Status := HMISVitals.Status::Triage;
                        HMISVitals."Current Location" := 'TRIAGE';
                        HMISVitals."Vitals No." := Rec."Triage No.";
                        HMISVitals.INSERT(TRUE);

                        //Create a Ledger Entry & Post Finances if Any..
                        HMISHospitalStandardCharges.RESET;
                        HMISHospitalStandardCharges.SETRANGE(Status, HMISHospitalStandardCharges.Status::Registration);
                        HMISHospitalStandardCharges.SETRANGE("Patient Type", Rec."Patient Type");
                        HMISHospitalStandardCharges.SETFILTER(Amount, '<>%1', 0);
                        IF HMISHospitalStandardCharges.FIND('-') THEN BEGIN
                            HMISHospitalStandardCharges.CALCSUMS(Amount);
                            HMISHospitalStandardCharges.CALCFIELDS("Charge Description");
                        END;
                        HMISPatientLedger.INIT;
                        HMISPatientLedger."Batch Date" := Rec."Batch Date";
                        HMISPatientLedger."Patient No." := Rec."Patient No.";
                        HMISPatientLedger."Transaction No." := NoSeriesManagement.GetNextNo(HMISNoSeries."Finance Trans. Nos.", TODAY, TRUE);
                        HMISPatientLedger."Visit No." := Rec."Visit Number";
                        HMISPatientLedger."User ID" := USERID;
                        HMISPatientLedger."Transaction Date/Time" := CURRENTDATETIME;
                        HMISPatientLedger."Transaction Description" := HMISHospitalStandardCharges."Charge Description";
                        HMISPatientLedger.Section := HMISPatientLedger.Section::Registration;
                        HMISPatientLedger."Insurance Code" := Rec."Insurance Firm Code";
                        HMISPatientLedger."Debit Amount" := HMISHospitalStandardCharges.Amount;
                        HMISPatientLedger.Amount := HMISHospitalStandardCharges.Amount;
                        HMISPatientLedger."External Document No." := Rec."Insurance Card No.";
                        HMISPatientLedger.INSERT(TRUE);

                        //Allocate Clinitian Here
                        /*CLEAR(Countz);
                        HMISCliniciansRegister.RESET;
                        HMISCliniciansRegister.SETFILTER("Active Login",'=%1',TRUE);
                        IF HMISCliniciansRegister.FIND('-') THEN BEGIN
                            REPEAT
                              BEGIN
                              Countz:=Countz+1;
                              HMISCliniciansRegister.CALCFIELDS("Patients on Queue");
                              HMISClinicianAllocationBuff.INIT;
                              HMISClinicianAllocationBuff."Record Count":=Countz;
                              HMISClinicianAllocationBuff."User ID":=HMISCliniciansRegister."User Name";
                              HMISClinicianAllocationBuff."Counted Patients":=HMISCliniciansRegister."Patients on Queue";
                              HMISClinicianAllocationBuff.INSERT(TRUE);
                              END;
                              UNTIL HMISCliniciansRegister.NEXT=0;
                          END ELSE ERROR('No CLinician in the System!');
                          HMISClinicianAllocationBuff.RESET;
                          HMISClinicianAllocationBuff.SETCURRENTKEY("Counted Patients");
                          IF HMISClinicianAllocationBuff.FIND('-') THEN BEGIN*/

                        IF Rec."Consultation Assigned to" = '' THEN
                            ERROR('You have not assigned a clinician');

                        HMISCliniciansRegister.RESET;
                        //HMISCliniciansRegister.SETRANGE("User Name",HMISClinicianAllocationBuff."User ID");
                        HMISCliniciansRegister.SETRANGE("User Name", Rec."Consultation Assigned to");
                        IF HMISCliniciansRegister.FIND('-') THEN BEGIN
                            Rec."Clinician Names" := HMISCliniciansRegister."Full Names";
                            Rec."Consultation Assigned" := TRUE;
                            Rec."Consultation Assigned to" := HMISCliniciansRegister."User Name";
                            Rec."Clinician User Name" := HMISCliniciansRegister."User Name";
                            Rec."Clinician ID" := HMISCliniciansRegister."ID No";
                            Rec."Clinician Names" := HMISCliniciansRegister."Full Names";
                            Rec.MODIFY;
                        END;
                        //END;
                        MESSAGE('Send to Clinitian:' + Rec."Clinician Names" + ', Room: ' + HMISCliniciansRegister."Current Room");
                    END ELSE
                        ERROR('Setup not found');
                    CurrPage.UPDATE;

                end;
            }
            action("To Observation Room")
            {
                Image = Continue;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Send to Observation Room?', TRUE) = FALSE THEN ERROR('Cancelled!');
                    HMISNoSeries.RESET;
                    IF HMISNoSeries.FIND('-') THEN BEGIN
                        HMISNoSeries.TESTFIELD("Observation Room");
                        Rec."Observation Room" := NoSeriesManagement.GetNextNo(HMISNoSeries."Observation Room", TODAY, TRUE);
                        //Update Current Status
                        Rec.Status := Rec.Status::Observation;
                        Rec."Current Location" := 'Observation';
                        Rec.MODIFY;
                    END;
                end;
            }
        }
        area(reporting)
        {
            group("Reports")
            {
                action("HMIS-Analysis By Diagnosis")
                {
                    Image = "Report";
                    ApplicationArea = All;
                    //RunObject = Report 64501;
                }
                action("Patients Reg. Report")
                {
                    Image = "Report";
                    ApplicationArea = All;
                    //RunObject = Report 64502;
                }
                action("Details Diagnosis Report")
                {
                    Image = "Report";
                    ApplicationArea = All;
                    // RunObject = Report 65590;
                }
                action("HMIS-Final Diagnosis Report")
                {
                    Image = Report2;
                    Promoted = false;
                    ApplicationArea = All;
                    // RunObject = Report 61300;
                }
            }
            group("&HMIS Forms")
            {
                Caption = '&HMIS Forms';
                action("Referral Form")
                {
                    Image = "Report";
                    ApplicationArea = All;
                    //RunObject = Report 51384;
                }
            }
        }
    }

    var
        HMISPatient: Record "HMIS-Patient";
        HMISPatientLedger: Record "HMIS-Patient Ledger";
        HMISCentralSetups: Record "HMIS-Central Setups";
        HMISCentralSetupValues: Record "HMIS-Central Setup Values";
        HMISVisitsRegistrations: Record "HMIS-Visits/Registrations";
        HMISDailyBatches: Record "HMIS-Daily Batches";
        HMISNoSeries: Record "HMIS-No. Series";
        HMISVitals: Record "HMIS-Vitals";
        NoSeriesManagement: Codeunit 396;
        HMISHospitalStandardCharges: Record "HMIS-Hospital Standard Charges";
        Countz: Integer;
}

