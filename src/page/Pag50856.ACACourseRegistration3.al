page 50856 "ACA-Course Registration 3"
{
    DeleteAllowed = true;
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Course Registration";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("Reg. Transacton ID"; Rec."Reg. Transacton ID")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programmes)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    Caption = 'Semester';
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    //Visible = true;
                }

                field("Year Of Study"; Rec."Year Of Study")
                {
                    ApplicationArea = All;
                }
                field("Special Exam Exists"; Rec."Special Exam Exists")
                {
                    Caption = 'Special Exams';
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Semester Total Units Taken"; Rec."Semester Total Units Taken")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Yearly Total Units Taken"; Rec."Yearly Total Units Taken")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Caption = 'Reg. Date';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Register for"; Rec."Register for")
                {
                    Editable = true;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Units Taken"; Rec."Units Taken")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Total Paid"; Rec."Total Paid")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Total Billed"; Rec."Total Billed")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field(Options; Rec.Options)
                {
                    ApplicationArea = All;
                }

                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    Caption = 'Stopped';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Reversing := TRUE;
                    end;
                }
                field("Stoppage Reason"; Rec."Stoppage Reason")
                {
                    ApplicationArea = All;
                }
                field("Stoppage Exists In Acad. Year"; Rec."Stoppage Exists In Acad. Year")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
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
            action("Student Units")
            {
                Caption = 'Student Units';
                Image = BOMRegisters;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "ACA-Student Units";
                RunPageLink = "Student No." = FIELD("Student No."),
                                  Semester = FIELD(Semester),
                                  Programme = FIELD(Programmes),
                                  Reversed = FILTER(false),
                                  Stage = FIELD(Stage)
                                  //   ,
                                  //   "Academic Year" = FIELD("Academic Year")
                                  ;
                ApplicationArea = All;
            }
            action("RepeatedUnits")
            {
                Caption = 'Repeated Units';
                Image = RegisterPutAway;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Repeated Units Registration";
                RunPageLink = "Student No." = FIELD("Student No."),
                                  Programme = FIELD(Programmes),
                                  Reversed = FILTER(false),
                                  Occurances = filter(> 1);
                ApplicationArea = All;
            }
            action(SuppExams)
            {
                Caption = 'Supplementary';
                Image = RegisteredDocs;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Supp. Exams Details List";
                RunPageLink = "Student No." = FIELD("Student No."), Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("2nd Supp. Exams")
            {
                Caption = 'Second Supplementary';
                Image = RegisteredDocs;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Second Supp Details";
                RunPageLink = "Student No." = FIELD("Student No."), Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action(RetakeExams)
            {
                Caption = 'Retake';
                Image = RegisteredDocs;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Retake Exam Details";
                RunPageLink = "Student No." = FIELD("Student No."), Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action(SpecialExamsReg)
            {
                Caption = 'Special Examination Reg.';
                Image = RegisterPick;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Special Exams Details List";
                RunPageLink = "Student No." = FIELD("Student No."), Semester = FIELD(Semester);
                ApplicationArea = All;
            }
            action("Student Charges")
            {
                Caption = 'Student Charges';
                Image = ReceivableBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "ACA-Student Charges";
                RunPageLink = "Student No." = FIELD("Student No."),
                                  "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
                RunPageView = WHERE(Posted = FILTER(false));
                ApplicationArea = All;
            }
            action("Posted Charges")
            {
                Caption = 'Posted Charges';
                Image = PostedVendorBill;
                Promoted = true;
                PromotedIsBig = false;
                PromotedOnly = true;
                RunObject = Page "ACA-Student Charges";
                RunPageLink = "Student No." = FIELD("Student No."),
                                  "Reg. Transacton ID" = FIELD("Reg. Transacton ID");
                RunPageView = WHERE(Posted = FILTER(true));
                ApplicationArea = All;
            }
            action("Mark as First Time")
            {
                Image = Agreement;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    IF Rec."First Time Student" THEN
                        IF CONFIRM('Do you really want to mark the registration as first time student?') THEN BEGIN
                            Rec."First Time Student" := TRUE;
                            Rec.MODIFY;

                        END;
                end;
            }

            action("UpdateYearOfStudy")
            {
                Image = UpdateUnitCost;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Corecgs: Record "ACA-Course Registration";
                    StudUnits: Record "ACA-Student Units";
                //   progre: Dialog;
                // NumberofCoregcs: Integer;
                //  RemainingCorecgs: Integer;
                // NumberofUnits: Integer;
                // RemainingUnits: Integer;

                begin
                    //  clear(NumberofCoregcs);
                    //  clear(RemainingCorecgs);
                    //  clear(NumberofUnits);
                    //   clear(RemainingUnits);
                    IF CONFIRM('Update?') THEN BEGIN
                        // progre.open('#1###########################################\' +
                        // '#2###########################################\' +
                        // '#3###########################################\');
                        // Corecgs.Reset();
                        // Corecgs.SetFilter(Stage, '<>%1', '');
                        // if Corecgs.find('-') then begin
                        //     NumberofCoregcs := Corecgs.count;
                        //     RemainingCorecgs := Corecgs.count;
                        //     progre.Update(1, 'Course Registration');
                        //     progre.Update(2, 'Total:  ' + format(NumberofCoregcs));
                        //     repeat
                        //     begin
                        //         progre.Update(3, 'Remaining: ' + format(RemainingCorecgs));
                        //         RemainingCorecgs := RemainingCorecgs - 1;
                        //         if ((Corecgs.Stage = 'Y1S1') OR (Corecgs.Stage = 'Y1S2') OR (Corecgs.Stage = 'Y1S3')) then
                        //             Corecgs."Year Of Study" := 1;

                        //         if ((Corecgs.Stage = 'Y2S1') OR (Corecgs.Stage = 'Y2S2') OR (Corecgs.Stage = 'Y2S3')) then
                        //             Corecgs."Year Of Study" := 2;

                        //         if ((Corecgs.Stage = 'Y3S1') OR (Corecgs.Stage = 'Y3S2') OR (Corecgs.Stage = 'Y3S3')) then
                        //             Corecgs."Year Of Study" := 3;

                        //         if ((Corecgs.Stage = 'Y4S1') OR (Corecgs.Stage = 'Y4S2') OR (Corecgs.Stage = 'Y4S3')) then
                        //             Corecgs."Year Of Study" := 4;

                        //         if ((Corecgs.Stage = 'Y5S1') OR (Corecgs.Stage = 'Y5S2') OR (Corecgs.Stage = 'Y5S3')) then
                        //             Corecgs."Year Of Study" := 5;

                        //         if ((Corecgs.Stage = 'Y6S1') OR (Corecgs.Stage = 'Y6S2') OR (Corecgs.Stage = 'Y6S3')) then
                        //             Corecgs."Year Of Study" := 6;
                        //         Corecgs.Modify();
                        //     end;
                        //     until Corecgs.Next() = 0;
                        // end;
                        // progre.Close();
                        // progre.open('#1###########################################\' +
                        // '#2###########################################\' +
                        // '#3###########################################\');
                        // Clear(NumberofUnits);
                        // Clear(RemainingUnits);
                        StudUnits.Reset();
                        StudUnits.SetFilter(Stage, '<>%1', '');
                        if StudUnits.find('-') then begin
                            // NumberofUnits := StudUnits.count;
                            // RemainingUnits := StudUnits.count;
                            // progre.Update(1, 'Units Reg.......');
                            // progre.Update(2, 'Total:  ' + format(NumberofUnits));
                            repeat
                            begin
                                //   progre.Update(3, 'Remaining: ' + format(RemainingUnits));
                                //  RemainingUnits := RemainingUnits - 1;
                                if ((StudUnits.Stage = 'Y1S1') OR (StudUnits.Stage = 'Y1S2') OR (StudUnits.Stage = 'Y1S3')) then
                                    StudUnits."Unit Year of Study" := 1;

                                if ((StudUnits.Stage = 'Y2S1') OR (StudUnits.Stage = 'Y2S2') OR (StudUnits.Stage = 'Y2S3')) then
                                    StudUnits."Unit Year of Study" := 2;

                                if ((StudUnits.Stage = 'Y3S1') OR (StudUnits.Stage = 'Y3S2') OR (StudUnits.Stage = 'Y3S3')) then
                                    StudUnits."Unit Year of Study" := 3;

                                if ((StudUnits.Stage = 'Y4S1') OR (StudUnits.Stage = 'Y4S2') OR (StudUnits.Stage = 'Y4S3')) then
                                    StudUnits."Unit Year of Study" := 4;

                                if ((StudUnits.Stage = 'Y5S1') OR (StudUnits.Stage = 'Y5S2') OR (StudUnits.Stage = 'Y5S3')) then
                                    StudUnits."Unit Year of Study" := 5;

                                if ((StudUnits.Stage = 'Y6S1') OR (StudUnits.Stage = 'Y6S2') OR (StudUnits.Stage = 'Y6S3')) then
                                    StudUnits."Unit Year of Study" := 6;
                                StudUnits.Modify();
                            end;
                            until StudUnits.Next() = 0;
                        end;

                        //   progre.Close();
                    END;
                end;
            }
        }
    }

    /* trigger OnAfterGetRecord()
    begin
        SETCURRENTKEY("Student No.", Stage);
        IF Cust.GET("Student No.") THEN
        //to do;
    end;
 */
    trigger OnInit()
    begin
        Rec.SETCURRENTKEY("Student No.", Stage);
    end;

    trigger OnOpenPage()
    begin
        Rec.SETCURRENTKEY("Student No.", Stage);
    end;

    var
        Cust: Record Customer;
}

