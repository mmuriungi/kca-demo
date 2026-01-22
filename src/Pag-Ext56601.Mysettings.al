// pageextension 56601 "My settings" extends "My Settings"
// {
//     layout
//     {
//         // Add changes to page layout here
//         modify(UserRoleCenter)
//         {
//             Visible = AllowChangeRole;
//         }
//         modify(Company)
//         {
//             Visible = AllowchangeCompanyName;
//         }

//     }
//     trigger OnOpenPage()
//     var
//         usersetup: Record "User Setup";
//         Nopermission: Label 'You do not have sufficient Rights';
//     begin
//         AllowChangeRole := true;
//         AllowchangeCompanyName := true;

//         if usersetup.get(UserId) then
//             if usersetup."Allow Open My Settings" then begin
//                 AllowChangeRole := usersetup."Allow Change Role";
//                 AllowchangeCompanyName := usersetup."Allow Change Company";
//                 exit
//             end;
//         Error(Nopermission);
//     end;



//     var
//         myInt: Integer;
//         AllowChangeRole: Boolean;
//         AllowchangeCompanyName: Boolean;
// }
