page 50547 "HRM-Appraisal emp2"
{
    Editable = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = "HRM-Employee C";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    Caption = 'No.(*)';
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    Caption = 'Name(*)';
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {

                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {

                    Editable = false;
                }
                field(Initials; Rec.Initials)
                {
                    Editable = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    Editable = false;
                }
                field("Postal Address"; Rec."Postal Address")
                {

                    Editable = false;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    Editable = false;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    Editable = false;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {

                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Student)
            {
                Caption = 'Employee';
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    //RunPageLink =  =CONST(Customer),
                    //"No."=FIELD("No.");
                }
                action("Appraisal Registrations")
                {
                    Caption = 'Appraisal Registrations';
                    RunObject = Page "HRM-Appraisal Registration 2";
                    // RunPageLink = "No."=FIELD("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //IF Name = '' THEN
        //ERROR('You must finish entry of the record.');;
        //OnAfterGetCurrRecord;
    end;

    var
        CourseRegistration: Record "HRM-Appraisal Registration";
        PictureExists: Boolean;
        CourseReg: Record "HRM-Appraisal Registration";
        districtname: Text[50];
        Cust: Record Customer;
        GenJnl: Record "Gen. Journal Line";
        PDate: Date;
        CReg: Record "HRM-Appraisal Registration";
        Prog: Record "HRM-Appraisal Jobs";
        TransInv: Boolean;
        TransRec: Boolean;
        CustL: Record "Cust. Ledger Entry";
        Stud: Record Customer;


}

