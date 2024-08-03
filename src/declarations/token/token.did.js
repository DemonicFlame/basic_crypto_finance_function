export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'balanceOf' : IDL.Func([IDL.Principal], [IDL.Nat, IDL.Text], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
