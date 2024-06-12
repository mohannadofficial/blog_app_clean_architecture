import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/core/network/connection_checker.dart';
import 'package:blog/core/secrets/app_secrets.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/repository/base_auth_repository.dart';
import 'package:blog/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:blog/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog/features/blog/data/repository/blog_repository.dart';
import 'package:blog/features/blog/domain/repository/base_blog_repository.dart';
import 'package:blog/features/blog/domain/usecases/add_new_blog_usecase.dart';
import 'package:blog/features/blog/domain/usecases/edit_blog_usecase.dart';
import 'package:blog/features/blog/domain/usecases/get_all_blog_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies.main.dart';
