page 50219 "Credit Management Setup"
{

    Caption = 'Credit Management Setup';
    PageType = Card;
    SourceTable = "Credit Management Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. of Days in Year"; Rec."No. of Days in Year")
                {
                    ApplicationArea = All;
                }
                field("Loan Disbursement Template"; Rec."Loan Disbursement Template")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest Template"; Rec."Loan Interest Template")
                {
                    ApplicationArea = All;
                }
                field("Loan Penalty Template"; Rec."Loan Penalty Template")
                {
                    ApplicationArea = All;
                }
                field("Default PML Posting Group"; Rec."Default PML Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Enforce Credit Limit"; Rec."Enforce Credit Limit")
                {
                    ApplicationArea = All;
                }
                field("Max Phone No Characters"; Rec."Max Phone No Characters")
                {
                    ApplicationArea = All;
                }
                field("Credit Limit Amount Type"; Rec."Credit Limit Amount Type")
                {
                    ApplicationArea = All;
                }
                field("Check Collateral Commitment"; Rec."Check Collateral Commitment")
                {
                    ApplicationArea = All;
                }
                field("Automatically Post Interest"; Rec."Automatically Post Interest")
                {
                    ApplicationArea = All;
                }
                field("VAT Product Posting Group"; Rec."VAT Product Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Receipt Amounts Exclusive VAT"; Rec."Receipt Amounts Exclusive VAT")
                {
                    ApplicationArea = All;
                }


            }
            group(Numbering)
            {
                field("Assumption Nos"; Rec."Assumption Nos")
                {
                    ApplicationArea = All;
                }

                field("Application Nos"; Rec."Application Nos")
                {
                    ApplicationArea = All;
                }
                field("PML Change Request Nos"; Rec."PML Change Request Nos")
                {
                    ApplicationArea = All;
                }

                field("Loan Nos"; Rec."Loan Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Disbursement Nos"; Rec."Loan Disbursement Nos")
                {
                    ApplicationArea = All;
                }
                field("Credit Scoring Nos"; Rec."Credit Scoring Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest Nos"; Rec."Loan Interest Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Penalty Nos"; Rec."Loan Penalty Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Receipt Nos"; Rec."Loan Receipt Nos")
                {
                    ApplicationArea = All;
                }
                field("Statement Template Nos"; Rec."Statement Template Nos")
                {
                    ApplicationArea = All;
                }
                field("Shareholding Setup Nos"; Rec."Shareholding Setup Nos")
                {
                    ApplicationArea = All;
                }
                field("Risk Profile Nos"; Rec."Risk Profile Nos")
                {
                    ApplicationArea = All;
                }
                field("Residential Mortgage Nos"; Rec."Residential Mortgage Nos")
                {
                    ApplicationArea = All;
                }
                field("Loan Collateral Nos"; Rec."Loan Collateral Nos")
                {
                    ApplicationArea = All;
                }
            }
            group(Signatories)
            {
                field("Signatory 1 No."; Rec."Signatory 1 No.")
                {
                    ApplicationArea = All;

                }
                field("Signatory 1 Name"; Rec."Signatory 1 Name")
                {
                    ApplicationArea = All;

                }
                field("Signatory 1 designation"; Rec."Signatory 1 designation")
                {
                    ApplicationArea = All;

                }
                field("Signatory 2 No."; Rec."Signatory 2 No.")
                {
                    ApplicationArea = All;

                }
                field("Signatory 2 Name"; Rec."Signatory 2 Name")
                {
                    ApplicationArea = All;

                }
                field("Signatory 2 designation"; Rec."Signatory 2 designation")
                {
                    ApplicationArea = All;

                }
            }
            group("Reports Text")
            {
                Caption = 'Reports Text';
                field("Statement Notes"; Rec."Statement Notes")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;

                    trigger OnValidate()
                    begin

                        
                    end;
                }
            }
            //     field("Contr Recon Notes"; CRNotesText)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         MultiLine = true;

            //         trigger OnValidate()
            //         begin
            //             CalcFields("Contr Recon Notes");
            //             "Contr Recon Notes".CreateInStream(Instr);
            //             CRNotes.Read(Instr);

            //             if CRNotesText <> Format(CRNotes) then begin
            //                 Clear("Contr Recon Notes");
            //                 Clear(CRNotes);
            //                 CRNotes.AddText(CRNotesText);
            //                 "Contr Recon Notes".CreateOutStream(OutStr);
            //                 CRNotes.Write(OutStr);
            //             end;
            //         end;
            //     }

            // }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    trigger OnAfterGetRecord()
    begin
 
    end;

    var
        SNotes: BigText;
        SNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;

}
