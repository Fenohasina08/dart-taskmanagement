class UrgentTask  extends Task{
  //NomDeLaClasseEnfant({
//   required super.premierAttribut,
//   required super.deuxiemeAttribut,
//   super.attributOptionnel,
//   super.attributAvecValeurParDefaut = Valeur,
// });

 UrgentTask({
    required super.id,
    required super.title,
    required super.priority,
    super.isCompleted = false,
  });

}