<%-- 
    Document   : mairie
    Created on : Apr 3, 2018, 5:07:03 PM
    Author     : boussanl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mairie</title>
        <link rel="stylesheet" type="text/css" href="style.css" />	
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
  
    </head>
    <body>
        <h1>Bonjour ${login}, vous êtes bien connectés</h1>
        <h2>Activités</h2>
        <div class="container">
            <div id = "activite" class="row">
                <div class="col">
                    <table border="1">
                        <tr>
                            <th>Nom</th>
                            <th>Créneaux</th>
                            <th>Classe</th>
                            <th>Prix</th>
                            <th>Effectif</th>
                            <th>Mail de l'accompagnateur 1</th>
                            <th>Mail de l'accompagnateur 2</th>
                        </tr>
                        <c:forEach items="${activites}" var="activite">
                            <tr>
                                <td>${activite.getNom()}</td>
                                <td>${activite.getCreneaux()}</td>
                                <td>${activite.getClasse()}</td>
                                <td>${activite.getPrix()}</td>
                                <td>${activite.getEffectif()}</td>
                                <td>${activite.getAccompagnateur1()}</td>
                                <td>${activite.getAccompagnateur2()}</td>
                                <td><a href="controleurMairie?action=activiteSupprimer&actiNom=${activite.getNom()}&actiCreneaux=${activite.getCreneaux()}">supprimer</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="col">
        <h3>Ajouter une activité</h3>
        <form method="get" action="controleurMairie" accept-charset="UTF-8">
            Nom de l'activité : <input type="text" name="nom" required/>
            <br/>
            Creneaux de l'activite : <input type='text' name="creneaux" required/>
            <br/>
            Classe(s) concernées : <input type='text' name="classes" required/>
            <br/>
            Prix de l'activité : <input type='number' name="prix" min=0 required/>
            <br/>
            Effectif de l'activité : <input type='number' name="effectif" min=0 required/>
            <br/>
            <c:if test="${illegalNumber == 1}">
                      <div style="color:red;">
                          Saisissez des nombres entiers pour le Prix et l'effectif
                      </div>
             </c:if>
            Mail de l'accompagnateur1 : <input type='text' name="mail1" required/>
            <br/>
            Mail de l'accompagnateur2: <input type='text' name="mail2" required/>
            <br/>
            <input type="submit" value="Ajouter" />
            <!-- Pour indiquer au contrôleur quelle action faire, on utilise un champ caché -->
            <input type="hidden" name="action" value="activiteAjouter" />
        </form>
        </div>
        </div>
    </div>
        <!-- Afficher les regimes -->
        <h2>Regime</h2>
        <table border="1">
            <c:forEach items="${regimes}" var="regime">
                <tr>
                    <td>${regime}</td>
                    <td><a href="controleurMairie?action=regimeSupprimer&regime=${regime}">supprimer</a></td>
                </tr>
            </c:forEach>                            
        </table>
        <br/>
        <h3>Ajouter un régime</h3>
          <form method="get" action="controleurMairie" accept-charset="UTF-8">
              Regime à ajouter : <input type="text" name="regime" required/>
            <input type="submit" value="Ajouter" />
            <!-- Pour indiquer au contrôleur quelle action faire, on utilise un champ caché -->
            <input type="hidden" name="action" value="regimeAjouter" />
          </form>
        
        <h2>Periode</h2>
        <table border="1">
            <c:forEach items="${periodes}" var="periode">
                <tr>
                    <td> Date début :${periode.getDateDebut()}</td>
                    <td> Date fin :${periode.getDateFin()}</td>
                    <td><a href="controleurMairie?action=periodeSupprimer&dateDebut=${periode.getDateDebut()}&dateFin=${periode.getDateFin()}">supprimer</a></td>
                </tr>
            </c:forEach> 
        </table>
        <h3>Ajouter une période</h3>
          <form method="get" action="controleurMairie" accept-charset="UTF-8">
            Date début (format AAAA-MM-JJ) : <input type="date" name="dateDebut"/> <br/>
            Date fin (format AAAA-MM-JJ) : <input type="date" name="dateFin"/> <br/>
            <input type="submit" value="Ajouter" />
            <!-- Pour indiquer au contrôleur quelle action faire, on utilise un champ caché -->
            <input type="hidden" name="action" value="periodeAjouter" />
          </form>
        <h3> Rajouter un employé de la mairie: </h3> <br/>
                  <form method="post" action="controleurMairie" accept-charset="UTF-8">
                    <ul>
                      <li> Créez un Login : <input type="text" name="login"/></li>
                      <li> Créez un Mot de passe : <input type="password" name="password1"/></li>
                      <li> Confirmez le Mot de passe : <input type="password" name="password2"/></li>
                    </ul>
                   <c:if test="${differentPassword == 1}">
                      <div style="color:red;">
                          Saisissez le même mot de passe
                      </div>
                   </c:if>
                   <c:if test="${loginUsed == 1}">
                      <div style="color:red;">
                          Ce login est déjà pris merci d'en choisir un autre !
                      </div>
                   </c:if>
                    <input type="submit" value="Création" />
                    <!-- Pour indiquer au contrôleur quelle action faire, on utilise un champ caché -->
                    <input type="hidden" name="action" value="creationCompteMairie" />
                  </form>
    </body>
           <form>
           <a href="controleurParent?action=logout"><input type="button" value="LogOut"></a>
        </form>
</html>
