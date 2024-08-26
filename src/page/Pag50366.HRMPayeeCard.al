page 50366 "HRM-Payee Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HRM-Other Payees";

    layout
    {
        area(content)
        {
            group("General Information")
            {
                field("No."; Rec."No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("ID Number"; Rec."ID Number")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Employee Terms Of Service"; Rec."Employee Terms Of Service")
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
            group("Contact Information")
            {
                field("Postal Address"; Rec."Postal Address")
                {
                }
                field("Residential Address"; Rec."Residential Address")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
            }
            group("Payment Information")
            {
                field("PIN Number"; Rec."PIN Number")
                {
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                }
                field("Main Bank"; Rec."Main Bank")
                {
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                }
                field("Branch Bank Name"; Rec."Branch Bank Name")
                {
                }
                field("Main Bank Name"; Rec."Main Bank Name")
                {
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    NotBlank = true;
                }
            }
            group("Credential Manager")
            {
                part(HRMemployeecredential; "HRM-employee credential")
                {
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Payee Memo")
            {
                Image = User;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    Customer: Record 18;
                begin
                    IF CONFIRM('Update Employee', TRUE) = FALSE THEN BEGIN
                        ERROR('Operation Cancelled');
                        EXIT;
                    END;

                    Customer.RESET;
                    Customer.SETFILTER("No.", '%1', Rec."No.");


                    IF Customer.FINDFIRST THEN BEGIN
                        MESSAGE('Already Updated');
                        EXIT;
                    END;

                    IF NOT Customer.FINDFIRST THEN BEGIN

                        Customer.INIT;
                        Customer."No." := Rec."No.";
                        Customer.Name := Rec."First Name" + ' ' + Rec."Last Name";
                        Customer."Customer Posting Group" := 'IMPREST';
                        Customer."Phone No." := Rec."Cellular Phone Number";
                        Customer."Gen. Bus. Posting Group" := 'LOCAL';
                        Customer."E-Mail" := Rec."E-Mail";
                        Rec.VALIDATE("No.");
                        Customer.INSERT(TRUE);
                        MESSAGE('Updated Successfully');
                    END;
                end;
            }
        }
    }
}

