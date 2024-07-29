page 54805 "FIN-Customer Card"
{
    PageType = Card;
    SourceTable = "HMS-Patient";

    layout
    {
        area(content)
        {
            group(General)
            {
                // field("No."; Rec."No.")
                // {
                // }
                // field(Name; Rec.Name)
                // {
                // }
                // field("Customer Posting Group"; Rec."Customer Posting Group")
                // {
                // }
                // field("Customer Type"; Rec."Customer Type")
                // {
                // }
                // field("Search Name"; Rec."Search Name")
                // {
                // }
                // field("Name 2"; Rec."Name 2")
                // {
                // }
                // field(Address; Rec.Address)
                // {
                // }
                // field("Address 2"; Rec."Address 2")
                // {
                // }
                // field(City; Rec.City)
                // {
                // }
                // field(Contact; Rec.Contact)
                // {
                // }
                // field("Phone No."; Rec."Phone No.")
                // {
                // }
                // field("Telex No."; Rec."Telex No.")
                // {
                // }
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                // }
                // field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                // {
                // }
                // field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                // {
                // }
                // field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                // {
                // }
                // field("Balance (LCY)"; Rec."Balance (LCY)")
                // {
                // }

                field("Date Registered"; Rec."Date Registered")
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
                field("Patient Ref. No."; Rec."Patient Ref. No.")
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                    Caption = 'Mode of Payment';
                    ApplicationArea = All;
                }
                field("Total Billed"; Rec."Total Billed")
                {
                    ApplicationArea = All;

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Image = PostedPayment;

                trigger OnAction()
                begin
                    //Assign transaction
                    PET.Reset;
                    //PET."Employee Code" := pf
                    //Create Ledger Entry
                end;
            }
        }
    }
    var
        PET: Record "PRL-Employee Transactions";
}

