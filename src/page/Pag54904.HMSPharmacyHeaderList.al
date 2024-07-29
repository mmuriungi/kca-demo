page 54904 "HMS-Pharmacy Header List"
{
    CardPageID = "HMS Pharmacy Header";
    PageType = List;
    SourceTable = "HMS-Pharmacy Header";
    SourceTableView = WHERE(Status = CONST(New));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pharmacy Date"; Rec."Pharmacy Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pharmacy Time"; Rec."Pharmacy Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Request Area"; Rec."Request Area")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill To Customer No."; Rec."Bill To Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issued By"; Rec."Issued By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Drug Issuance")
                {
                    Caption = 'Post Drug Issuance';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PostItems();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        PatientName: Text[100];
        ItemJnlLine: Record 83;
        LineNo: Integer;
        HMSSetup: Record "HMS-Setup";
        PharmHeader: Record "HMS-Pharmacy Header";
        PharmLine: Record "HMS-Pharmacy Line";
        Patient: Record "HMS-Patient";
        TreatmentLine: Record "HMS-Treatment Form Drug";


    procedure PostItems()
    begin
        IF CONFIRM('Do you wish to post the record?', FALSE) = FALSE THEN BEGIN EXIT END;
        HMSSetup.RESET;
        HMSSetup.GET();
        ItemJnlLine.RESET;
        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SETRANGE(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        IF ItemJnlLine.FIND('-') THEN ItemJnlLine.DELETEALL;
        LineNo := 0;
        PharmLine.RESET;
        PharmLine.SETRANGE(PharmLine."Pharmacy No.", Rec."Pharmacy No.");
        IF PharmLine.FIND('-') THEN BEGIN

                                        REPEAT
                                            LineNo := LineNo + 1000;
                                            ItemJnlLine.INIT;
                                            ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                                            ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                                            ItemJnlLine."Line No." := LineNo;
                                            ItemJnlLine."Posting Date" := TODAY;
                                            ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                                            ItemJnlLine."Document No." := PharmLine."Pharmacy No." + ':' + PharmLine."Drug No.";
                                            ItemJnlLine."Item No." := PharmLine."Drug No.";
                                            ItemJnlLine.VALIDATE(ItemJnlLine."Item No.");
                                            ItemJnlLine."Location Code" := HMSSetup."Pharmacy Location";
                                            ItemJnlLine.VALIDATE(ItemJnlLine."Location Code");
                                            ItemJnlLine.Quantity := PharmLine."Issued Quantity";
                                            ItemJnlLine.VALIDATE(ItemJnlLine.Quantity);
                                            ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                                            ItemJnlLine.VALIDATE(ItemJnlLine."Unit of Measure Code");
                                            ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                                            ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                                            ItemJnlLine.INSERT();
                                            PharmLine.Remaining := PharmLine.Remaining - PharmLine."Issued Units";
                                            PharmLine.MODIFY;
                                            LineNo := LineNo + 1;
                                            /*Update the treatment lines*/
                                            TreatmentLine.RESET;
                                            TreatmentLine.SETRANGE(TreatmentLine."Treatment No.", Rec."Link No.");
                                            TreatmentLine.SETRANGE(TreatmentLine."Drug No.", PharmLine."Drug No.");
                                            IF TreatmentLine.FIND('-') THEN BEGIN
                                                TreatmentLine.Issued := TRUE;
                                                TreatmentLine.MODIFY;
                                            END;
                                        UNTIL PharmLine.NEXT = 0;
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJnlLine);

            Rec.Status := Rec.Status::Completed;
            Rec.MODIFY;
        END;

    end;


    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.RESET;
        PatientName := '';
        IF Patient.GET(PatientNo) THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        END;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
    end;
}

