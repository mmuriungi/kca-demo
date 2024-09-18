table 51293 "Prequalification Application"
{
    DrillDownPageId = "Prequalification Application";
    LookupPageId = "Prequalification Application";
    fields
    {
        field(1; "VAT Registration No."; Code[30])
        {

        }
        field(2; "Period"; Code[30])
        {
            TableRelation = "Proc-Prequalification Years"."Preq. Year";
        }
        field(3; "Name"; Text[100])
        {

        }
        field(4; Phone; Text[100])
        {

        }
        field(5; Email; Text[250])
        {

        }
        field(6; "Address"; Text[100])
        {

        }
        field(7; "Postal Code"; Text[100])
        {

        }
        field(8; "Contact Person"; Text[100])
        {

        }
        field(9; "Contact Telephone"; Code[30])
        {

        }
        field(10; "Document Date"; Date)
        {

        }
        field(11; "Prequalified"; Boolean)
        {

        }
        field(12; "Date Prequalified"; Date)
        {

        }
        field(13; "Prequalified By"; Code[30])
        {

        }
        field(14; "Status"; Option)
        {
            OptionMembers = New,Submitted;
        }
        field(15; "Agpo Categorization"; Code[30])
        {
            TableRelation = "Proc-Target Groups"."Code";
        }
        field(16; "Agpo Certificate No."; Text[30])
        {

        }

    }

    keys
    {
        key(pk; "VAT Registration No.", "Period")
        {

        }
    }

    trigger OnInsert()
    var
        period: Record "Proc-Prequalification Years";
    begin
        period.Reset();
        period.SetRange("Active Period", true);
        if period.Find('+') then
            Rec.Period := period."Preq. Year";
    end;


    procedure Prequlification(var Preq: Record "Prequalification Application")
    var
        appCat: Record "Preq Application categories";
        vend: Record Vendor;
        preqCat: Record "Proc-Preq. Suppliers/Category";
    begin

        vend.Reset();
        vend.SetRange("No.", Preq."VAT Registration No.");
        if vend.Find('-') then begin
            appCat.Reset();
            appCat.SetRange("VAT Registration", "VAT Registration No.");
            if appCat.Find('-') then begin
                repeat
                    if appCat."Category Approved" = appCat."Category Approved"::Approved
                    then begin
                        preqCat.Init();
                        preqCat."Preq. Year" := Preq.Period;
                        preqCat."Preq. Category" := appCat.Category;
                        preqCat.Supplier_Code := appCat."VAT Registration";
                        preqCat.Validate(Supplier_Code);
                        preqCat.Insert();
                    end


                until appCat.Next() = 0;
            end;

        end else begin
            vend.Init();
            vend."No." := Preq."VAT Registration No.";
            vend.Validate("No.");
            vend.Name := Preq.Name;
            vend."VAT Registration No." := Preq."VAT Registration No.";
            vend.Address := Preq.Address;
            vend."Post Code" := Preq."Postal Code";
            vend."E-Mail" := Preq.Email;
            vend."Email 1" := Preq.Email;
            vend."Email 2" := Preq.Email;
            vend."Contact Person" := Preq."Contact Person";
            vend."Contact Telephone" := Preq."Contact Person";
            vend."Phone No." := Preq.Phone;
            vend.Contact := preq.Phone;
            vend."Vendor Categorization" := Preq."Agpo Categorization";
            vend."Agpo Certification No." := Preq."Agpo Categorization";
            vend."Gen. Bus. Posting Group" := 'DOMESTIC';
            vend.Validate("Gen. Bus. Posting Group");
            vend."VAT Bus. Posting Group" := 'ZERO VAT';
            vend.Validate("VAT Bus. Posting Group");
            vend."Invoice Disc. Code" := Preq."VAT Registration No.";
            vend."Vendor Posting Group" := 'TRADE';
            vend.Validate("Vendor Posting Group");
            vend.Insert();

            appCat.Reset();
            appCat.SetRange("VAT Registration", "VAT Registration No.");
            if appCat.Find('-') then begin
                repeat
                    if appCat."Category Approved" = appCat."Category Approved"::Approved
                    then begin
                        preqCat.Init();
                        preqCat."Preq. Year" := Preq.Period;
                        preqCat."Preq. Category" := appCat.Category;
                        preqCat.Supplier_Code := appCat."VAT Registration";
                        preqCat.Validate(Supplier_Code);
                        preqCat.Insert();

                        appCat.Prequalified := true;
                        appCat.Modify();

                    end
                until appCat.Next() = 0;
            end;
        end;
        Preq.Prequalified := true;
        Preq."Date Prequalified" := Today;
        Preq."Prequalified By" := UserId;
        Preq.Modify();
        Message('Complete');
    end;
}