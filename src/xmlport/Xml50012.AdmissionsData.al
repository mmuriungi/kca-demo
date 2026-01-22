xmlport 50012 "Admissions Data"
{
    Direction = Export;
    Format = VariableText;
    FormatEvaluate = Legacy;
    DefaultFieldsValidation = false;
    UseRequestPage = false;
    Caption = 'Admissions Data';
    FieldSeparator = ',';
    //FieldSeparatorFormat = '<None>';

    schema
    {
        textelement(Admissions)
        {
            tableelement(ACAApplicFormHeader; "ACA-Applic. Form Header")
            {
                // Handle headers for each field
                fieldelement(AdmissionNo; ACAApplicFormHeader."Admission No")
                {

                }
                fieldelement(IndexNumber; ACAApplicFormHeader."Index Number")
                {

                }
                fieldelement(FirstDegreeChoice; ACAApplicFormHeader."First Degree Choice")
                {

                }
                fieldelement(programName; ACAApplicFormHeader.programName)
                {

                }
                fieldelement(Email; ACAApplicFormHeader.Email)
                {

                }
                fieldelement(StudentEmail; ACAApplicFormHeader."Student E-mail")
                {

                }
                fieldelement(DateOfBirth; ACAApplicFormHeader."Date Of Birth")
                {

                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(ExportOptions)
                {
                    Caption = 'Export Options';
                    field(IncludeHeaders; IncludeHeaders)
                    {
                        Caption = 'Include Headers';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
                action(Export)
                {
                    ApplicationArea = All;
                    Caption = 'Export';
                    trigger OnAction()
                    begin
                        // Add custom logic for the export action if needed
                    end;
                }
            }
        }
    }

    var
        IncludeHeaders: Boolean;
}
