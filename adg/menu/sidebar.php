

<ul class="nav p-0">
          
          


          <?php if($id_role==1 OR $id_role==2 OR $id_role==3): ?>
          <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#consulter_donnees" aria-expanded="false" aria-controls="ui-basic">
              <i class="fa fa-database menu-icon"></i>
              <span class="menu-title">Travailler sur les données</span>
              <i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="consulter_donnees">
              <ul class="nav flex-column sub-menu">
                <li class="nav-item preprarerDonnees"> <a class="nav-link" href="">Préparer les données</a></li>

                <!-- <li class="nav-item"> <a class="nav-link" href="consulterrealisation">Par trimestre</a></li>
                <li class="nav-item"> <a class="nav-link" href="consulterrealisation">Par semestre</a></li>
                <li class="nav-item"> <a class="nav-link" href="consulterrealisation">Par année</a></li> -->
              </ul>
            </div>
          </li>
          <?php endif; ?>


         


          

          
        </ul>