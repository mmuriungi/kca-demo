page 54983 "HMS-Treatment History List"
{
    CardPageID = "HMS Treatment Form History";
    //Editable = false;
    PageType = List;
    SourceTable = "HMS-Treatment Form Header";
    SourceTableView = WHERE(Status = CONST(Completed));
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Treatment No."; Rec."Treatment No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Treatment Type"; Rec."Treatment Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Treatment Date"; Rec."Treatment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field(Diagnosis; Rec.Diagnosis)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Diagnosis field.';
                } */
                field("Diagnosis Two"; Rec."Diagnosis Two")
                {
                    editable = true;
                    Caption = 'Diagnosis';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Diagnosis Two field.';
                }

                field("Treatment Remarks"; Rec."Treatment Remarks")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
            group("&Treatment Details")
            {
                Caption = '&Treatment Details';
                Image = Ledger;
                action(Processes)
                {
                    Caption = 'Processes';
                    Image = Production;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Processes";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Signs)
                {
                    Caption = 'Signs';
                    Image = RegisteredDocs;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Measuring Unit Card";
                    RunPageLink = code = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Symptoms)
                {
                    Caption = 'Symptoms';
                    Image = RegisterPick;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Measuring Unit List";
                    RunPageLink = code = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(History)
                {
                    Caption = 'History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action("Laboratory Needs")
                {
                    Caption = 'Laboratory Needs';
                    Image = TestFile;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Laboratory";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action("Radiology Needs")
                {
                    Caption = 'Radiology Needs';
                    Image = ReleaseShipment;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Radiology";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Diagmnosis)
                {
                    Caption = 'Diagmnosis';
                    Image = AnalysisView;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Diagnosis";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Injections)
                {
                    Caption = 'Injections';
                    Image = Reconcile;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Injection";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Prescriptions)
                {
                    Caption = 'Prescriptions';
                    Image = ItemAvailability;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Drug";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Referrals)
                {
                    Caption = 'Referrals';
                    Image = Reconcile;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Referral";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Admissions)
                {
                    Caption = 'Admissions';
                    Image = Account;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Admission";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    // trigger OnInit()
    // begin
    //     CurrPage.LOOKUPMODE := TRUE;
    // end;
}

